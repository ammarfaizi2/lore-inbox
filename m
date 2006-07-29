Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWG2S3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWG2S3w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWG2S3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:29:52 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:61620 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932206AbWG2S3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:29:52 -0400
Date: Sat, 29 Jul 2006 12:29:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: A better interface, perhaps: a timed signal flag
In-reply-to: <fa.7gpoVg9wmtQ0g4u4T8FaCZGXup0@ifi.uio.no>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Tso <tytso@mit.edu>,
       Neil Horman <nhorman@tuxdriver.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Message-id: <44CBA91A.5030704@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.xkoDc6Uvpcp6dnG8+9iwy53PPeo@ifi.uio.no>
 <fa.7gpoVg9wmtQ0g4u4T8FaCZGXup0@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> There's also something else that would be a nice addition to the kernel
> API.  A sleep and wakeup that is implemented without signals. Similar to
> what the kernel does with wake_up.  That way you can sleep till another
> process/thread is done with what it was doing and wake up the other task
> when done, without the use of signals.  Or is there something that
> already does this?

For between threads, this is what the POSIX pthread API is for 
(pthread_cond_wait and friends) which is implemented using futexes these 
days..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

