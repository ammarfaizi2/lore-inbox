Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270746AbRIFNZT>; Thu, 6 Sep 2001 09:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRIFNZL>; Thu, 6 Sep 2001 09:25:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270712AbRIFNYw>; Thu, 6 Sep 2001 09:24:52 -0400
Subject: Re: page_launder() on 2.4.9/10 issue
To: garloff@suse.de (Kurt Garloff)
Date: Thu, 6 Sep 2001 14:28:14 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel),
        phillips@bonn-fries.net (Daniel Phillips),
        jaharkes@cs.cmu.edu (Jan Harkes),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906151827.F21793@gum01m.etpnet.phys.tue.nl> from "Kurt Garloff" at Sep 06, 2001 03:18:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ezCY-00087e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just use two limits:
> * Time: After some time (say two seconds), we can always afford to write it
>   out=20
> * Queue filling: After it has a certain size, it's worth doing a writing.

Both debatable and both I can find counter cases for - think about a shared
memory database with multiple game clients using it (eg the older AberMUD
codebase). Writing that to disk is counterproductive
