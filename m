Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314137AbSDZTbV>; Fri, 26 Apr 2002 15:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSDZTbV>; Fri, 26 Apr 2002 15:31:21 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:20802 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S314137AbSDZTbU>; Fri, 26 Apr 2002 15:31:20 -0400
Message-ID: <3CC9AAEC.5010503@blue-labs.org>
Date: Fri, 26 Apr 2002 15:30:52 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020418
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Woller, Thomas" <twoller@crystal.cirrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3+ sound distortion, cs64xx driver, help please
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugg, guess nobody is interested or cares about this chipset :)

I'll keep fishing until someone who is clued in this chipset can help.

-d

+++++++++
March 6th, 2002

I have several questions regarding the Santa Cruz Voyetra:

a) please read the below text and those in the know, please advise me of
any updates to the current situation where sound is very tinny.  at
present i have to deal with this constantly.
b) there have been some vague references made to adjusting the other
line IN/OUT channels which in the source i read from, stated that this
seems to act as a fade control and was able to adjust the level of
tinniness that was heard.
c) are there any (linux/open source) mixers which have the capability of
controlling this card in any fashion that is better than the dark age
mixers currently found on freshmeat?  i.e., something that takes
advantage of the gobs of onboard features such as the onboard hardware
equalizer, configurable in/out ports, etc.
d) if no to (c), is Mr. Woller from cirrus.com interested in helping us
develop such features in a mixer application?

David

Recap from April of 2001;

Woller, Thomas said:

David,
your report sounds like a problem that we have seen in the test lab, but no
one has reported in the field... yet. :)
if the problem is the same as we have seen... unloading the driver and
reloading the driver should also clear up the problem. but typically the
problem only occurs after playing for several hours without a break in the
audio stream.

we think that we understand the problem (theoretically), in that we believe
that we need to manipulate a static DSP image location periodically that
gets too far out of value. the issue is that internal variables for the
static DSP image are not reinitialized on a task restart (e.g. restarting up
an audio stream). reloading the static image (i.e. suspend/resume or
reloading the driver) clears up the *tinny* sound here. it hadn't been
reported, so I haven't taken the time to plough through the static image map
to try to figure out where all the locations are for all the task images
that need manipulation. might take a while, but since we now have a problem
report, i'll try to find some time to start negotiating the DSP map. i'll
send the fix to you for testing when/if... i can get the problem resolved.
thanks

tom
twoller@crystal.cirrus.com <mailto:twoller@crystal.cirrus.com>

/> -----Original Message-----/
/> From: David [SMTP:david@blue-labs.org]/
/> Sent: Sunday, April 22, 2001 10:08 PM/
/> To: *linux*-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>/
/> Subject: Re: 2.4.3+ sound distortion/
/> /
/> I have noticed a problem with sound lately. I have a *cs46xx* card and /
/> it randomly gets distorted. Normally I just reboot but on this last /
/> occurence I simply left it as it was. The distortion sounds someone /
/> punched the speaker core, it's *tinny* and mangled. Today it fixed
itself /
/> out of the blue in the middle of playing a sound. All sound programs
are /
/> equally affected./
/> /
/> It's only done this in the 2.4 series, I haven't had the desire to look /
/> into it./
/> /
/> David/




