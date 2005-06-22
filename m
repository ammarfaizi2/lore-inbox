Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVFVAWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVFVAWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVFVAT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:19:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30397 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262398AbVFVAOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:14:04 -0400
Subject: Re: SCHED_RR/SCHED_FIFO and kernel threads?
From: Lee Revell <rlrevell@joe-job.com>
To: Patrik =?ISO-8859-1?Q?H=E4gglund?= <patrik.hagglund@bredband.net>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <42B89227.6050501@bredband.net>
References: <42B199FF.5010705@bredband.net> <42B19F65.6000102@nortel.com>
	 <42B26FF8.6090505@bredband.net>
	 <1119011872.4846.12.camel@localhost.localdomain>
	 <42B3D7E2.2070600@bredband.net>  <42B89227.6050501@bredband.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 21 Jun 2005 20:13:57 -0400
Message-Id: <1119399237.9814.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 00:18 +0200, Patrik Hägglund wrote:
> The only clean solution is probably to have priorities that are 
> exclusively reserved for use by the kernel. I saw that kernel threads
> in LynxOS may use a priority of 1/2 above of the user-space tasks it 
> serves. This seems like a good solution to the problem. 

No, it's not, because some SCHED_FIFO/SCHED_RR threads do not need any
kernel services, and are perfectly happy with stalling the rest of the
kernel until they're done.

Lee

