Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUELSXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUELSXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbUELSXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:23:52 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:64199 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265152AbUELSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:23:48 -0400
Date: Wed, 12 May 2004 19:22:27 +0100
From: Dave Jones <davej@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mason@suse.com,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH] [2.6] Make reiserfs not to crash on oom
Message-ID: <20040512182227.GA16687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Oleg Drokin <green@linuxhacker.ru>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mason@suse.com,
	reiserfs-dev@namesys.com
References: <20040512165038.GA72981@linuxhacker.ru> <20040512180145.GA1573@redhat.com> <20040512182035.GC7474@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512182035.GC7474@linuxhacker.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 09:20:35PM +0300, Oleg Drokin wrote:

 > > (Ditto some of the other failure paths too)
 > No, there is "vfree(SB_JOURNAL(p_s_sb)) ;" at the end of free_journal_ram()
 > that is called if we jump to that free_and_return label.

Ah, I overlooked the double assignment of the vmalloc result 8)

		Dave

