Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTHJN6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTHJN6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:58:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:7626 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S267520AbTHJN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:58:35 -0400
Date: Sun, 10 Aug 2003 14:58:01 +0100
From: Dave Jones <davej@redhat.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.0-test3] i386 msr.c devfs support 1/2
Message-ID: <20030810135800.GA17154@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200308101251.03605.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308101251.03605.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 12:51:03PM +0400, Andrey Borzenkov wrote:
 > Please let me know if default permissions (644) are not appropriate.

bogus. They should be set to 600. Non-root access to MSRs (even read
only) can cause instant lockup/reboot on some CPUs if user tries to
read non-existant MSR.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
