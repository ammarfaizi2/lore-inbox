Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSIBItc>; Mon, 2 Sep 2002 04:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSIBItc>; Mon, 2 Sep 2002 04:49:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33732 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318230AbSIBItb>;
	Mon, 2 Sep 2002 04:49:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Sep 2002 10:53:55 +0200 (MEST)
Message-Id: <UTC200209020853.g828rtj03830.aeb@smtp.cwi.nl>
To: neilb@cse.unsw.edu.au, torvalds@transmeta.com
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HOWEVER, that disk change checking really should be done by
> the generic layers, and it should be done after the open() anyway
> (and not by the open)

Are you sure?
I am inclined to think that this would be an undesirable change of
open() semantics. Traditionally, and according to all standards,
open() will return ENXIO when the device does not exist.

Andries
