Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALESW>; Thu, 11 Jan 2001 23:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRALESM>; Thu, 11 Jan 2001 23:18:12 -0500
Received: from relay1.pair.com ([209.68.1.20]:22276 "HELO relay1.pair.com")
	by vger.kernel.org with SMTP id <S129675AbRALESE>;
	Thu, 11 Jan 2001 23:18:04 -0500
X-pair-Authenticated: 203.164.4.223
From: "Manfred Bartz" <md-linux-kernel@logi.cc>
Message-ID: <20010112041630.32368.qmail@logi.cc>
To: linux-kernel@vger.kernel.org
Subject: Re: Anyone else interested in a high-precision monotonic counter?
In-Reply-To: <Pine.BSF.4.21.0012180711330.89819-100000@beppo.feral.com> <3A3E336C.B29BBA89@nortelnetworks.com> <14912.11470.540247.408234@diego.linuxcare.com.au> <3A550AC8.D22D0CE4@nortelnetworks.com> <20010105032900.22980.qmail@logi.cc> <3A55DC2E.9C342224@nortelnetworks.com>
X-Subversion: anarchy bomb crypto drug explosive fission gun nuclear sex terror
In-Reply-To: "Christopher Friesen"'s message of "Fri, 05 Jan 2001 09:37:34 -0500"
Organization: rows-n-columns
Date: 12 Jan 2001 15:16:30 +1100
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortelnetworks.com> wrote:

> Manfred Bartz wrote:
> 
> > Why a new system call?
> Well, you'd be accessing a different kernel variable--"ytime" instead of
> "xtime". This new variable wouldn't be adjusted when the  system
> time/date was, it would start at zero and always increase. 

> > have you looked at the return-value of times(2)
> > Or roll your own using setitimer(2)
> 
> Both of these are precise only to jiffies, which defaults at 10
> milliseconds on x86 and PPC.  If you want microsecond timing, the only
> current standard way to do it is to use gettimeofday(), which is
> sensitive to changes in system date and time.

Ok.  A monotonic, high resolution timer would be useful.

Maybe one should then push for a full implementation of xtime
including TIME_MONOTONIC and TIME_TAI?

        <http://www.cl.cam.ac.uk/~mgk25/c-time/>
        <http://cr.yp.to/time.html>

-- 
Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
