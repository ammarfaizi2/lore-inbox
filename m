Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWAUD46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWAUD46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWAUD46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:56:58 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2947 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161058AbWAUD45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:56:57 -0500
Subject: Re: My vote against eepro* removal
From: Lee Revell <rlrevell@joe-job.com>
To: John Ronciak <john.ronciak@gmail.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, kus Kusche Klaus <kus@keba.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <56a8daef0601201801s6f8c3b79xcc06aaacc430309d@mail.gmail.com>
References: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
	 <20060120095548.GA16000@2ka.mipt.ru> <1137804050.3241.32.camel@mindpipe>
	 <56a8daef0601201719t448a6177lfebabe3ca38a00c7@mail.gmail.com>
	 <1137807048.3241.58.camel@mindpipe>
	 <56a8daef0601201801s6f8c3b79xcc06aaacc430309d@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 22:56:53 -0500
Message-Id: <1137815814.3241.138.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 18:01 -0800, John Ronciak wrote:
> There is a timer routine in the eepro100 driver which does the check
> for link as well as a check for on of the hang conditions (with
> work-around).  It does the check for link in a different way than
> e100.  e100 uses mii call where eepro100 does it manually.  Another
> difference is that eepro100 doesn't get stats unless called by the
> system.  It's not in the timer routine at all.
> 
> Can we try a couple of things? 1) just comment out all the check for
> link code in the e100 driver and give that a try and 2) just comment
> out the update stats call and see if that works.  These seem to be the
> differences and we need to know which one is causing the problem.

Heh, FWIW, Microsoft found this exact same bug with 2 different chipsets
in their latency testing (see section 4.4):

http://research.microsoft.com/~mbj/papers/tr-98-29.html

Lee

