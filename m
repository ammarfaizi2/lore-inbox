Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312286AbSCTXcV>; Wed, 20 Mar 2002 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312285AbSCTXcM>; Wed, 20 Mar 2002 18:32:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312284AbSCTXbz>; Wed, 20 Mar 2002 18:31:55 -0500
Subject: Re: [PATCH] 2.4.19-pre3 - readv/writev should return EINVAL for count=0
To: plars@austin.ibm.com (Paul Larson)
Date: Wed, 20 Mar 2002 23:48:00 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosati),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <1016650428.2202.98.camel@plars.austin.ibm.com> from "Paul Larson" at Mar 20, 2002 12:53:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16npoG-0003hz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a minor patch against 2.4.19-pre3 for readv/writev to have it
> return EINVAL if count=0 is passed to it.  According to the man page and
> also the specifications for readv/writev, this is the correct behaviour.

I beg to disagree. The existing behaviour is compliant. The behaviour for
writing/reading 0 may optionally return -EINVAL. (Single Unix Spec v3).

Alan
