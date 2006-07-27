Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWG0RNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWG0RNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWG0RNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:13:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:27066 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751794AbWG0RNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zy3sY1aKHbd0BJcuUrq3/umdPSkrQDXkz/qOTJ05NbzKXWpyHmwVomUFD75DKbWuUGkGHi7OWfsqIkMbqXHFYRx4ZLwZ3KowGB28iX/LYx47+j3noPq2pwtyB+Rpdd8Qfir0AoDYNyJFsL+sG7uuG5ZWQEwATzBq5sxkWhuxdAo=
Message-ID: <a36005b50607271013o3c03238fq4ecea87dcd3c1e90@mail.gmail.com>
Date: Thu, 27 Jul 2006 10:13:13 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> Sure. Though I wonder if sys_frevoke is enough for us and we can drop
> sys_revoke completely.

No, you want sys_revoke/sys_revokeat.  Simplest case: /dev/rst0 vs
/dev/nrst0.  You don't want the open rewind the drive.
