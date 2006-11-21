Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWKUIlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWKUIlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966111AbWKUIlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:41:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:45936 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965885AbWKUIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:41:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DNhK+PRzUuJoE0WHek1v1nR+e8AqV50fIAI5eKG5toZtWmL6FiNKMzLE4E3T3oyBFtLsqbufrsgjiSTa5/nCQdeOPjkKvHPrnbRWhYjm+jiUUeeA8s05/Svpn2GHIVR0kqdHpddlztTAmWIEMkh9FeoJu/BEfkMpEYWassC3PM8=
Message-ID: <38b2ab8a0611210041o2f5d251ale17082b951a90abb@mail.gmail.com>
Date: Tue, 21 Nov 2006 09:41:22 +0100
From: "Francis Moreau" <francis.moro@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: Re : vm: weird behaviour when munmapping
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611201213460.11655@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com>
	 <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
	 <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
	 <Pine.LNX.4.64.0611201213460.11655@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Mon, 20 Nov 2006, Francis Moreau wrote:
> >
> > I end up to see "open(B), close(B)" sequence when unmapping a part of
> > the dumb device that I found strange. I think that "open(A') close(B)"
> > can give more information to the driver and reflect that B is unmapped
> > and A' is still mapped and becomes the new mapped area.
> > But it's may be just me...
>
> I think I do now get your point.  But your way round doesn't really

my fault, I think I wasn't very clear when explaining myself

> reflect what's going on either: the range A' was already open and now
> you open it again.  Until there's some driver actually needing more
> sophisticated treatment, let's just leave it the simple way it is.

Yes, I agree that both ways are not satisfacting. Maybe having
vma->resize() method would have been better, I dunno.

Anyways thanks for your answers.
-- 
Francis
