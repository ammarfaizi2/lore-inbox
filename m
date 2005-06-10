Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVFJHix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVFJHix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFJHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:38:53 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:61277 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262504AbVFJHit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:38:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=julOK3tTCdqYItBKbsfGbDUn2y95ywaNGmdCH0b/CeVknnCcNC7y4Co/jxNTAl53rOtEWtaT8Pn+zqCF3o5TRMoSeKwtshqT7e31rX7KP69oDIBbS1hRjbWtqrC9u6eDjcBCFcbQn0Q2GMmPPCTdprfdKhBPcU7U5Ond/DtoSoE=
Message-ID: <2cd57c90050610003831a4bfa2@mail.gmail.com>
Date: Fri, 10 Jun 2005 15:38:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Subject: Re: [patch] next_mnt() cleanup
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050610072344.GA6629@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050610072344.GA6629@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, this is insane, forget it.


On 6/10/05, Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> hello,
> 
> This is an obvious cleanup to next_mnt() by making use of list_empty().
> 
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
> 
> --- linux-2.6.12-rc5-mm2/fs/namespace.c 2005-06-06 09:24:44.000000000 +0800
> +++ linux-2.6.12-rc5-mm2-cy/fs/namespace.c      2005-06-10 14:56:47.000000000 +0800
> @@ -133,8 +133,7 @@ static void attach_mnt(struct vfsmount *
> 
>  static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
>  {
> -       struct list_head *next = p->mnt_mounts.next;
> -       if (next == &p->mnt_mounts) {
> +       if (list_empty(&p->mnt_mounts)) {
>                 while (1) {
>                         if (p == root)
>                                 return NULL;
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
