Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWAGPFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWAGPFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWAGPFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:05:07 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30345 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1030470AbWAGPFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:05:05 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: kernel coder <lhrkernelcoder@gmail.com>
Subject: Re: Almost 80% of UDP packets dropped
Date: Sat, 7 Jan 2006 17:04:52 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com>
In-Reply-To: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071704.52833.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 09:03, kernel coder wrote:
> hi,
>     I was trying to measure the UDP reception speed on my borad which
> has MIPS 4kc processor with 133 MHZ speed.I was transfering 10mb file
> from intel pentium 4 machine to MIPS board,but the recieved file was
> only 900kB.

UDP is connectionless. There is no way for sender to know that it must
stop sending UDP packets because receiver cannot keep up. If sender
and your network is producing and delivering UDP packets faster
than receiver can consume them, packets will be lost.

Use TCP instead.
--
vda
