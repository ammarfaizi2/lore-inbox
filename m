Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280968AbRKCPhS>; Sat, 3 Nov 2001 10:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKCPhI>; Sat, 3 Nov 2001 10:37:08 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:10500 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280968AbRKCPgv>; Sat, 3 Nov 2001 10:36:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: graphical swap comparison of aa and rik vm
Date: Sat, 3 Nov 2001 10:36:49 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0111021110000.2963-100000@imladris.surriel.com> <20011102234857Z280889-17409+7968@vger.kernel.org>
In-Reply-To: <20011102234857Z280889-17409+7968@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011103153658Z280968-17408+9781@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since i'm now in Linus' kernel, i did the test again on it with the added 
swap.  It took about 7 minutes to finish.  Since rik's vm locked up so 
completly after only about a minute, i really have no data on what it was 
doing during those 8 hours i had it running it's course.  Andrea's was more 
fruitful and vmstat ran quite nicely the entire time, probably only missing a 
couple here and there.  
The only thing i could tell from the two tests is that Rik's vm allocates all 
of my memory and swap almost immediately and for extended periods of time.  
Andrea's alocates memory gradually and more conservatively and only reaches 
all of my swap for an instant.  Other than that the only thing i can tell is 
that my computer is usable when using andrea's vm after the test.  I have to 
reboot it after starting the test with Rik's vm. 




On Friday 02 November 2001 18:48, safemode wrote:
> So I added more swap, for 461549568 bytes total, and guess what happens? 
> No, Rik's vm did not beat AA's.  You might say, "well then it must have
> came close to tying it now since it has enough swap and wont fall victim to
> the 'speed/size tradeoff'".  No, you would be wrong.  Rik's VM completely
> locked up in some kind of infinite swap loop like it did before in earlier
> kernels. My server was swapping ( i saw disk activity) for over 8 hours
> before i finally rebooted it.  Needless to say that it angers me to
> unintentionally lock the computer up.  So what's going on here? rik,
> anyone?  I've used this test before to lock up Rik's VM and it is
> reproduceable on my machine.  With less swap, it seems to be gone in the
> latest kernels but when i added more like Rik said to do, it locked up. 
> For now i'll be running AA kernels until this is figured out.
> What i found insane from the little info provided by the vmstat i had
> running at the time was that even with 450+MB of swap, Rik's VM still used
> it all up. Why would it work better without that much ram but when i add
> more, it still uses it all up and locks up.  There's something seriously
> wrong here. I'm going to test's andrea's with the new mem config too later.
>   My bet is that it doesn't lock up for over 8 hours trying to swap.
