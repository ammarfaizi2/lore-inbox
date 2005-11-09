Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVKIMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVKIMAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKIMAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:00:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58345 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751387AbVKIMAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:00:19 -0500
Subject: Re: video4linux user land API concern
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <05G2L0Z12@briare1.heliogroup.fr>
References: <05G2L0Z12@briare1.heliogroup.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Nov 2005 12:31:14 +0000
Message-Id: <1131539474.6540.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-09 at 10:26 +0000, Hubert Tonneau wrote:
> Any Video4Linux driver should support both native hardware color encoding
> (for maximum performances) and rgb (for maximum flexibility).
> 
> Requiering user land tools to be prepared to match the webcam native color
> encoding is poor kernel API design for several reasons:

The kernel API was designed on the basis that someone would one day have
the sense to write a nice user space library of formats. 

> . if new color models appear in new cameras, the current design will require
>   to map them anyway to some existing encodings not to break existing softwares,
>   so the end result will be even more confusing because the driver supporting a
>   non rgb encoding will not necessary mean that selecting the encoding is better
>   from the performances point of view

Many of the encodings done by hardware are extremely complicated and
tricky to unpack in kernel space. If a camera captures jpeg for example
you don't want in kernel jpeg decoders, let alone mpeg decoders etc

