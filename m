Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUK2Pvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUK2Pvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUK2Pvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:51:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261747AbUK2Pmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:42:53 -0500
Date: Mon, 29 Nov 2004 10:41:47 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Adrian Bunk <bunk@stusta.de>
cc: sds@epoch.ncsc.mil, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: Re: [2.6 patch] selinux: possible cleanups
In-Reply-To: <20041128190139.GD4390@stusta.de>
Message-ID: <Xine.LNX.4.44.0411291040320.6506-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Nov 2004, Adrian Bunk wrote:

> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - avc.c: avc_ss_grant
>   - avc.c: avc_ss_try_revoke
>   - avc.c: avc_ss_revoke
>   - avc.c: avc_ss_set_auditallow
>   - avc.c: avc_ss_set_auditdeny
>   - ss/avtab.c: avtab_map
>   - ss/ebitmap.c: ebitmap_or
>   - ss/hashtab.c: hashtab_remove
>   - ss/hashtab.c: hashtab_replace
>   - ss/hashtab.c: hashtab_map_remove_on_error
>   - ss/services.c: security_member_sid
>   - ss/sidtab.c: sidtab_remove
> - remove the following unused static functions:
>   - avc.c: avc_update_cache
>   - avc.c: avc_control
> 

I think these functions were going to be left in for possible future use, 
but it's probably better to remove them and add them back only if 
necessary.


- James
-- 
James Morris
<jmorris@redhat.com>


