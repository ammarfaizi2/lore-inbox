Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755018AbWKLJGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbWKLJGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 04:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbWKLJGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 04:06:43 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:15264 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1755018AbWKLJGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 04:06:42 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 10:05:58 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200611112334.28889.bero@arklinux.org> <4556D9C0.3050103@qumranet.com>
In-Reply-To: <4556D9C0.3050103@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121005.58939.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 12. November 2006 09:22, Avi Kivity wrote:
> Bernhard Rosenkraenzer wrote:
> > drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
> > drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible
> > constraints drivers/kvm/kvm_main.c:158: error: 'asm' operand has
> > impossible constraints
>
> Smells like a gcc regression.  Can you send .config?
>
> Or better yet, preprocessed source and full gcc command line (as seen on
> 'make V=1').

It does look like a gcc bug -- -O0 makes it go away.
Details at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29808
