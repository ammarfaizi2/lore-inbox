Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284668AbRLDAVD>; Mon, 3 Dec 2001 19:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284495AbRLDAQJ>; Mon, 3 Dec 2001 19:16:09 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33029 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284406AbRLCKXn>; Mon, 3 Dec 2001 05:23:43 -0500
Date: Mon, 3 Dec 2001 11:23:40 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011203112339.A3529@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011125133020.C1811@emma1.emma.line.org> <20011125150433.CEAE889CAD@pobox.com> <20011125173125.A13119@emma1.emma.line.org> <20011127023923.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011127023923.A38@toy.ucw.cz>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Pavel Machek wrote:

> > Note, the specifications say that the write cache setting is ignored
> > when the drive runs out of spare blocks for reassignment after defects
> > (so that the drive can return the error code right away when it cannot
> > guarantee the write actually goes to disk).
> 
> They should turn off write-back after number-of-spare-block < cache-size,
> otherwise they are not safe.

I don't know exactly what they're doing, but they also need to safeguard
against defective spare blocks, so number-of-space-blocks < cache-size
is not sufficient.
