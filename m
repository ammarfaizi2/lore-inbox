Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVJQVna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVJQVna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJQVna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:43:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1525 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S932263AbVJQVna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:43:30 -0400
Date: Mon, 17 Oct 2005 14:43:24 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <20051017160536.GA2107@elte.hu>
Message-ID: <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655872-1753810980-1129585404=:24518"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655872-1753810980-1129585404=:24518
Content-Type: TEXT/PLAIN; charset=US-ASCII


I found this latency ~5 minutes after boot up, no load . It looks like
vgacon_scroll() has a memset like operation which can grow. 

Daniel


On Mon, 17 Oct 2005, Ingo Molnar wrote:

> 
> i have released the 2.6.14-rc4-rt7 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change is the merging of "ktimers next step", a'ka the 
> clockevents framework, from Thomas Gleixner. This is mostly a design 
> cleanup of the existing timekeeping, timer and HRT codebase. One 
> user-visible aspect is that the PIT timer is now available as a hres 
> source too - APIC-less systems will find this useful.
> 
> otherwise, there are lots of fixes all across the spectrum.
> 
> Changes since 2.6.14-rc4-rt1:
> 
> - clockevents framework (Thomas Gleixner)
> 
> - ktimer and HRT updates (Thomas Gleixner)
> 
> - robust futex updates (David Singleton)
> 
> - symbol export fixes (Steven Rostedt)
> 
> - export tsc_c3_compensate for real (reported by Rui Nuno Capela)
> 
> - fix for the nanosleep() -ERESTARTBLOCK bug
>   (reported by Fernando Lopez-Lezcano)
> 
> - x64 latency tracer fixes (reported by Mark Knecht)
> 
> - PRINTK_IGNORE_LOGLEVEL bugfix
> 
> - various build fixes
> 
> to build a 2.6.14-rc4-rt7 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc4.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc4-rt7
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--655872-1753810980-1129585404=:24518
Content-Type: APPLICATION/octet-stream; name="trace2-1.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10510171443240.24518@godzilla.mvista.com>
Content-Description: 
Content-Disposition: attachment; filename="trace2-1.bz2"

QlpoOTFBWSZTWZr2kwAAGjP/gHT+EABob//zTEpLBL/v/zRgB38Gj2VlLZqX
ce4xAA8Cw1ETEBkDI00NANNMmhkxGJp6E0w1PCISommJgmABNMATaTTJiYCE
VP9qqNAAANAAAAAAAANP1RKmoyaB6ho0AAA0AAAAHMAmAmRgBGJiYTCYIaYm
mAVFEjIRpo1NGpqfqT1MnpAGjEeTSBptTanZ8rI9FkA8iszOJbHXu7cRyskk
kzx5cdXTt4c/b7P96apzWRIP+Ugh8KPduecKQHz+nT8dPhu8/z0kz/f18ZJD
jjdpyfVIBvRgqQVUWyKVLLEsQfh+vX4wfGQf9dEHjB+Wn5QaIOzjB6M+Hoxm
5zjNznGblpltMtpltMtpltMtpltMtpltMvOM3OcZuc4zcXm+fnMQQdJFpD+t
MIR21ITtQSfb4fVXXd6jgkTDfhBdvTmDP8fruMsVB2/N1z9njhIk5NfHv/Bo
kB693Xdm7RwXHRvp5pGFo1esmmWXZprK1guIQxwtIpAiGOENEpAxRiFolIGK
OFpFIgxRwtFIomGOEFkoEQxwh2Xca1mVqxdxq9ZpMsuzTWaDJaGKMQtEpAxR
iFolIGKOFopEKGMaLYGs9kk/zPW9OMrfYQFnDXz6XzSAe6QDp91+3qf0rp7f
VPbdquu1q220tpQJxjOMAAAfs+X1W20265Ik6pElCRBzNCqbPz7syOMS2lJS
xI4MIwtFluGDBLbc4hi2rbFkUpDK8MW/t5J+yzVVRRXLq3BSRqsjGLFFABAg
korAxctCWlpJ3uVeAJqTZhWK3eTrN5vbKnAQFnIgK4W1LZbwm/vcOLTTRovT
TOjdkgN/47Ri2S2LVpaudVm/bNztnuyMg4JBOCMGs5CSHg5Uk1ZN3d2KbaSV
zW5tmW2ba8GMbb8Z4bsr5bRsu4gLMWpatki+YjoBP9IxUdBwlcGjoDQBwLOl
nRMYcgeUKsk4JIAIBAkFVd1WeLRVi3dm5379+uuut3537/p4ET41D3hUSSxP
dZhADHFH9OBynhX6MHZ5SA7AFiEAAAKJTfTGMEcIKmUnwtVJu1JPJUk4qkmS
pGRAAEQABxTv1JPfJKqbalSVwye6VJFgAAAACLXEu5dri1xa4YGBDIQyEMhD
IQyEMhDJgYYGMXC4qGBIwheFiEzmDBYPsgxB5wYfGITsg4QkdkHKanxIDjug
7J80gG3H64OMgz3YWrVq1aIQhCEIQhCL69ST9/xuTbuZVSSbIlSTUqSpWqqS
m+AAAAAQAAAAAVJUjwa936rBi3rBtBgg9n6e7gIm3yg6u04yE6iRmwiYgp49
0HPu5N9N2xub27XqJGu8g+/RB6Ob7sSDWIThqkB4859OIPSgsHTl9/y8CDly
6JCV38Omgkc0OMImjw6QEpnMHODRDyRE0g3dVPLregZekNkRMOLCETckJtB6
uwhJ15wd22vZCSG8kJt2IPLe+GyQnPneRjmSE6u7v6OLwaZSE6iR3weBxiG1
kJehITy246oO0hukElSJYHv8oLw74NYOcHIyZgygxBkgNWIMVB79oCcCQlgt
Ijux6vKITkQZ5aIOEhvyWhyucABYwAOYBjAGPDjz+r1Jevk/q5DdTHJJlXeZ
IaqWv7zpqs6zIbq1YNSkpfsvW7O7rSrbW73ncn8HdaJGtpZrd743wd5VcZar
jiSGqkoRSkpni9SuNsVq9pTe7mtnesrOktazcmzUWlVve971uTgzPGtpZvdy
cGotBVaUq74lbsEOnaUzdzWjmxbSve7zvjjf690EYA7AAxgEYB3wVCfRYMER
4/QHhN8H+DfPlh2VLVFXn/F3JFOFCQmvaTAA
--655872-1753810980-1129585404=:24518--
