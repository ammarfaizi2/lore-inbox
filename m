Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTIPLtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTIPLtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:49:18 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:31119 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261838AbTIPLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:49:15 -0400
Date: Tue, 16 Sep 2003 12:48:12 +0100
From: Dave Jones <davej@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart's MODULE_ALIAS is broken
Message-ID: <20030916114812.GB8753@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200309161141.h8GBfqZv012047@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309161141.h8GBfqZv012047@harpo.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 01:41:52PM +0200, Mikael Pettersson wrote:

 > With 2.6.0-test5, the generated alias for agpgart
 > in modules.alias looks wrong:
 > 
 > alias char-major-10-AGPGART_MINOR agpgart
 > 
 > Surely that should be char-major-10-175.
 > 
 > The problem is that AGP's MODULE_ALIAS_MISCDEV() is in
 > backend.c, but AGPGART_MINOR isn't #define:d there
 > because agpgart.h is only #include:d in frontend.c.
 > This causes MODULE_ALIAS_MISCDEV()'s __stringify()
 > to convert the token itself rather than its value.
 > 
 > Should be easy to fix (move the ALIAS or add #include).

Should be fixed in agpgart bk tree. I'm waiting on Linus
to return before I push updates..

	Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
