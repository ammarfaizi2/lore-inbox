Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293037AbSBVXPW>; Fri, 22 Feb 2002 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293038AbSBVXPM>; Fri, 22 Feb 2002 18:15:12 -0500
Received: from sushi.toad.net ([162.33.130.105]:48596 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S293037AbSBVXPB>;
	Fri, 22 Feb 2002 18:15:01 -0500
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
From: Thomas Hood <jdthood@mail.com>
To: Benedikt Heinen <beh@icemark.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202222133570.1183-100000@berenium.icemark.ch>
In-Reply-To: <Pine.LNX.4.44.0202222133570.1183-100000@berenium.icemark.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 18:15:25 -0500
Message-Id: <1014419727.3977.3.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-22 at 15:43, Benedikt Heinen wrote: 
> Apparently, that's where you're wrong... I tried removing some
> modules, until I found the one causing the trouble:
> 
> 	snd-card-intel8x0
> I guess it's time to check for newer version on that... :/

ALSA device drivers have routines that save and restore 
the state of sound chips across suspend & resume. 
That's where I'd go a-hunting for bugs. 


