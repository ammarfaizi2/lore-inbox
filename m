Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVBCAtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVBCAtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVBCAts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:49:48 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:52612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262864AbVBCAr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:47:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SkjE0/Pts2muLl15pR2XfY2Sab/SpHTitQDYIudJfEKLURkIPRMVpR0UUt/1KT5sI62V/jHfxPuInqIk1gCfmA0zTQtEehIBhg7xJAGBjDoX0sxFwJNlRTah7HjBhCvYtkPGHmbGypH/jk+y37gafwOySzUNsX0CZrhDHa26uYA=
Message-ID: <58cb370e05020216476a8f403c@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:47:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025448.GL621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 11_ide_drive_sleeping_fix.patch
> >
> >       ide_drive_t.sleeping field added.  0 in sleep field used to
> >       indicate inactive sleeping but because 0 is a valid jiffy
> >       value, though slim, there's a chance that something can go
> >       weird.  And while at it, explicit jiffy comparisons are
> >       converted to use time_{after|before} macros.

Same question as for "add ide_hwgroup_t.polling" patch.
AFAICS drive->sleep is either '0' or 'timeout + jiffies' (always > 0)
