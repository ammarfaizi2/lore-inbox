Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbTI1G6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 02:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTI1G6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 02:58:50 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:12931
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262332AbTI1G6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 02:58:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Date: Sun, 28 Sep 2003 17:03:53 +1000
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309281703.53067.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003 11:27, Linus Torvalds wrote:
> from Andrew Morton. Most notably perhaps Con's scheduler changes that have
> been discussed extensively and made it into the -mm tree for testing.

For those who are trying this for the first time, please note that the 
scheduler has been tuned to tell the difference between tasks of the _same_ 
nice level. This means do NOT renice X or it will make audio skip unless you 
also renice your audio application by the same amount. Lots of distributions 
have done this for the old 2.4 scheduler which could not treat equal "nice" 
levels as differently as the new scheduler does and 2.6 shouldn't need 
special treatment.

So for testing note the following points:

Make sure X is NOT reniced to -10 as many distributions are doing.
Some shells spawn processes at nice +5 by default and this will make audio 
apps suffer.
Make sure your hard disk, graphics card and audio card are performing at equal 
standard to your 2.4 kernel (ie dma is working, graphics is fully accelerated 
etc).

before commenting on audio performance.

Con

