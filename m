Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264877AbUDWQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbUDWQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUDWQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:58:21 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:13191 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264877AbUDWQ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:57:53 -0400
Date: Fri, 23 Apr 2004 18:57:40 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Felipe W Damasio <felipewd@terra.com.br>
cc: linux-kernel@vger.kernel.org, sisopiii-l@cscience.org
Subject: Re: [PATCH] 32-bit process accounting
In-Reply-To: <4089227C.9060101@terra.com.br>
Message-ID: <Pine.LNX.4.53.0404231848260.9664@gockel.physik3.uni-rostock.de>
References: <4089227C.9060101@terra.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Felipe W Damasio wrote:

@@ -41,8 +41,8 @@
>   *     No binary format break with 2.0 - but when we hit 32bit uid we'll
>   *     have to bite one
>   */
> -	__u16           ac_uid;                 /* Accounting Real User ID 
> */
> -	__u16           ac_gid;                 /* Accounting Real Group ID */
> +	uid_t           ac_uid;                 /* Accounting Real User ID */
> +	gid_t           ac_gid;                 /* Accounting Real Group ID */
> 	__u16           ac_tty;                 /* Accounting Control Terminal */
> 	__u32           ac_btime;               /* Accounting Process Creation Time */
> 	comp_t          ac_utime;               /* Accounting User Time */

This breaks binary compatibility, so you should change the comment as well.

Seriously, it's of course better not to break binary compatibility, as in
this patch
  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2004-Week-11/1337.html

I have to admit that things are moving a bit slow as I had no spare time 
to push this patch. Will try to do that in the next week.

Tim
