Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269486AbTCDSIS>; Tue, 4 Mar 2003 13:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269487AbTCDSIS>; Tue, 4 Mar 2003 13:08:18 -0500
Received: from h007.c015.snv.cp.net ([209.228.35.122]:63965 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id <S269486AbTCDSIR>;
	Tue, 4 Mar 2003 13:08:17 -0500
X-Sent: 4 Mar 2003 18:18:45 GMT
Message-ID: <3E64EE6A.90208@lemur.sytes.net>
Date: Tue, 04 Mar 2003 13:20:26 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
Reply-To: mathias.kretschmer@verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE DVD reading & error handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a way to optimize the IDE layer to handle DVD
read errors more gracefully ?

Most used DVDs (borrowed from a local library, etc.) seem to have some 
defects. Those cause the IDE layer to get stuck for quite a while, 
interrupting the movie playback. It might be better to just return an 
error for that sector and let the player software continue.

I wonder if it would be possible to tune the IDE layer by i.e.
reducing the number of retries and disabling the controller reset, etc.

I haven't fiddle with the below numbers, yet. Just wondering if that
could improve the situation, or if there are any other tricks that one 
could play here ?

/*
  * Probably not wise to fiddle with these
  */
#define ERROR_MAX       8       /* Max read/write errors per sector */
#define ERROR_RESET     3       /* Reset controller every 4th retry */
#define ERROR_RECAL     1       /* Recalibrate every 2nd retry */

Cheers,

Mathias

PS: Also which DVD ROM do people recommended in general ?
     Which one seems to have a decent error correction scheme
     not just a high read speed?

