Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316631AbSEWNLa>; Thu, 23 May 2002 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSEWNL3>; Thu, 23 May 2002 09:11:29 -0400
Received: from [62.70.58.70] ([62.70.58.70]:9872 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316631AbSEWNL1> convert rfc822-to-8bit;
	Thu, 23 May 2002 09:11:27 -0400
Message-Id: <200205231311.g4NDBO613726@mail.pronto.tv>
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4 VM sucks. Again
Date: Thu, 23 May 2002 15:11:24 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I've been here complaining about the 2.4 VM before, and here I am, back again.

PROBLEM:
----------------------
Starting up 30 downloads from a custom HTTP server (or Tux - or Apache - 
doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After some 
time the kernel (a) goes bOOM (out of memory) if not having any swap, or (b) 
goes gong swapping out anything it can.

The custom HTTP server processes each have a static buffer of two megabytes, 
no malloc()s, and are written in < 1000 lines of C.

Theory: The buffer fills up, as the clients can't read as fast as kernel is 
reading from disk, and the server goes boom

thanks for any help

roy


-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
