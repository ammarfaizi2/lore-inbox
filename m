Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEDcs>; Thu, 4 Jan 2001 22:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbRAEDci>; Thu, 4 Jan 2001 22:32:38 -0500
Received: from relay1.pair.com ([209.68.1.20]:35334 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S129387AbRAEDc3>;
	Thu, 4 Jan 2001 22:32:29 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010105032900.22980.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: Anyone else interested in a high-precision monotonic counter?
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com> <3A3E336C.B29BBA89@nortelnetworks.com> <14912.11470.540247.408234@diego.linuxcare.com.au> <3A550AC8.D22D0CE4@nortelnetworks.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
Organization: rows-n-columns
Date: 05 Jan 2001 14:29:00 +1100
In-Reply-To: "Christopher Friesen"'s message of "Thu, 04 Jan 2001 18:44:08 -0500"
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortelnetworks.com> writes:

> Has anyone ever considered including a microsecond-precision
> monotonically-increasing counter in the kernel?  This would allow for
> easy timing of alarms and such by using absolute values of when the
> alarm should expire rather than a list of deltas from previous alarms.
> 
> The thing I have in mind would store a value something like "xtime"
> (maybe call it "ytime"?) in the kernel.  This value would be initialized
> to zero on startup, and would be incremented at the same time as
> "xtime".  However, while "xtime" reflects adjustments to the actual
> system time (settimeofday(), date, ntp, etc.), this value would not. 
> Finally, it would be accessed with a system call essentially identical
> to sys_gettimeofday(), only it would access "ytime" instead of "xtime"
> before going down and getting the microseconds from the RTC.
> 
> This doesn't seem to me as though it would be all that tricky to add,
> and I could see it being very useful in providing a timing source that
> is guaranteed to 
>         a) be accurate to microseconds and 
>         b) never go backwards.

Why a new system call?  

regarding a:  it could have microsecond resolution but not
              microseconds accuracy.
regarding b:  have you looked at the return-value of times(2)
              Or roll your own using setitimer(2)
-- 
Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
