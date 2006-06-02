Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWFBFzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFBFzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFBFzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:55:48 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:60002 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751157AbWFBFzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:55:48 -0400
Message-ID: <447FD2E1.7060605@bigpond.net.au>
Date: Fri, 02 Jun 2006 15:55:45 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, Sam Vilain <sam@vilain.net>,
       ckrm-tech@lists.sourceforge.net, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
In-Reply-To: <1149187413.13336.24.camel@linuxchandra>
Content-Type: multipart/mixed;
 boundary="------------050405030407020507070308"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Jun 2006 05:55:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405030407020507070308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chandra Seetharaman wrote:
> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
>> Hi, Kirill,
>>
>> Kirill Korotaev wrote:
>>>> Do you have any documented requirements for container resource 
>>>> management?
>>>> Is there a minimum list of features and nice to have features for 
>>>> containers
>>>> as far as resource management is concerned?
>>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
>>> required resource management. BTW, I must agree with other people here 
>>> who noticed that per-process resource management is really useless and 
>>> hard to use :(
> 
> I totally agree.

"nice" seems to be doing quite nicely :-)

To me this capping functionality is a similar functionality to that 
provided by "nice" and all that's needed to make it useful is a command 
(similar to "nice") that runs tasks with caps applied.  To that end I've 
written a small script (attached) that does this.  As this is something 
that a user might like to combine with "nice" the command has an option 
for setting "nice" as well as caps.

Usage:
         withcap [options] command [arguments ...]
         withcap -h
Options:
         [-c <CPU rate soft cap>]
         [-C <CPU rate hard cap>]
         [-n <nice value>]

         -c Set CPU usage rate soft cap
         -C Set CPU usage rate hard cap
         -n Set nice value
         -h Display this help

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050405030407020507070308
Content-Type: application/x-shellscript;
 name="withcap.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="withcap.sh"

IyEvYmluL3NoCiMKIyBDb3B5cmlnaHQgKGMpIDIwMDYgYnkgUGV0ZXIgV2lsbGlhbXMKIyBB
bGwgcmlnaHRzIHJlc2VydmVkCiMKIyBBdXRob3I6IFBldGVyIFdpbGxpYW1zIDxwd2lsMzA1
OEBiaWdwb25kLm5ldC5hdT4KIwojIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkK
IyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vu
c2Ugb25seS4KIwojIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAojIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiMgTUVSQ0hBTlRBQklMSVRZIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQojIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCgpteXVzYWdlX2xvdyAoKSB7
CgllY2hvICJVc2FnZToiCgllY2hvIC1lICJcdHdpdGhjYXAgW29wdGlvbnNdIGNvbW1hbmQg
W2FyZ3VtZW50cyAuLi5dIgoJZWNobyAtZSAiXHR3aXRoY2FwIC1oIgoJZWNobyAiT3B0aW9u
czoiCgllY2hvIC1lICJcdFstYyA8Q1BVIHJhdGUgc29mdCBjYXA+XSIKCWVjaG8gLWUgIlx0
Wy1DIDxDUFUgcmF0ZSBoYXJkIGNhcD5dIgoJZWNobyAtZSAiXHRbLW4gPG5pY2UgdmFsdWU+
XSIKfQoKbXl1c2FnZSAoKSB7CglteXVzYWdlX2xvdwp9CgpteWhlbHAgKCkgewoJbXl1c2Fn
ZV9sb3cKCWVjaG8KCWVjaG8gLWUgIlx0LWMgU2V0IENQVSB1c2FnZSByYXRlIHNvZnQgY2Fw
IgoJZWNobyAtZSAiXHQtQyBTZXQgQ1BVIHVzYWdlIHJhdGUgaGFyZCBjYXAiCgllY2hvIC1l
ICJcdC1uIFNldCBuaWNlIHZhbHVlIgoJZWNobyAtZSAiXHQtaCBEaXNwbGF5IHRoaXMgaGVs
cCIKfQoKY2ZsYWc9CkNmbGFnPQpuZmxhZz0KaGZsYWc9CndoaWxlIGdldG9wdHMgYzpDOmhu
OiBuYW1lCmRvCgkjIG5vIG9wdGlvbnMgYWZ0ZXIgLWgKCWlmIFsgISAteiAiJGhmbGFnIiBd
IDsgdGhlbgoJCW15dXNhZ2UKCQlleGl0IDEKCWZpCgoJIyBwcmV2ZW50IGR1cGxpY2F0ZSBh
cmd1bWVudHMKCWV2YWwgdGhpc2ZsYWc9XCQke25hbWV9ZmxhZwoJaWYgWyAhIC16ICIkdGhp
c2ZsYWciIF0gJiYgWyAiJHRoaXNmbGFnIiAhPSAiMGZsYWciIF07Cgl0aGVuCgkJZWNobyAt
ZSAiRXJyb3I6IG11bHRpcGxlIHVzZSBvZiAtJG5hbWUgb3B0aW9uXG4iCgkJbXl1c2FnZQoJ
CWV4aXQgMQoJZmkKCWNhc2UgJG5hbWUgaW4KCWMpCWlmIFsgISAteiAiYGVjaG8gIiRPUFRB
UkciIHwgZ3JlcCAnXlswLTldWzAtOV0qJCdgIiBdOwoJCXRoZW4KCQkJY2ZsYWc9MQoJCQlz
b2Z0X2NhcD0iJE9QVEFSRyIKCQllbHNlCgkJCWVjaG8gLWUgIi1jICRPUFRBUkc6IHBvc2l0
aXZlIGludGVnZXIgZXhwZWN0ZWQiCgkJCWV4aXQgMgoJCWZpCgkJOzsKCUMpCWlmIFsgISAt
eiAiYGVjaG8gIiRPUFRBUkciIHwgZ3JlcCAnXlswLTldWzAtOV0qJCdgIiBdOwoJCXRoZW4K
CQkJQ2ZsYWc9MQoJCQloYXJkX2NhcD0iJE9QVEFSRyIKCQllbHNlCgkJCWVjaG8gLWUgIi1D
ICRPUFRBUkc6IHBvc2l0aXZlIGludGVnZXIgZXhwZWN0ZWQiCgkJCWV4aXQgMgoJCWZpCgkJ
OzsKCWgpCWhmbGFnPTEKCQk7OwoJbikJbmZsYWc9MQoJCW5pY2U9IiRPUFRBUkciCgkJZWNo
byAibiBzZWVuIgoJCTs7Cgk/KQlteXVzYWdlCgkJZXhpdCAxCgkJOzsKCWVzYWMKZG9uZQpz
aGlmdCBgZXhwciAkT1BUSU5EIC0gMWAKaWYgWyAhIC16ICIkaGZsYWciIF07IHRoZW4KCW15
aGVscAoJZXhpdCAwCmZpCiMgbXVzdCBoYXZlIHNvbWUgYXJndW1lbnRzIGFmdGVyIHRoZSBv
cHRpb25zCmlmIFsgLXogIiQqIiBdOyB0aGVuCgllY2hvIC1lICJFcnJvcjogY29tbWFuZCBl
eHBlY3RlZFxuIgoJbXl1c2FnZQoJZXhpdCAxCmZpCgppZiBbICEgLXogIiRjZmxhZyIgXTsg
dGhlbgoJaWYgISBlY2hvICRzb2Z0X2NhcCA+IC9wcm9jLyQkL3Rhc2svJCQvY3B1X3JhdGVf
Y2FwOyB0aGVuCgkJZWNobyAiRXJyb3I6IHNldHRpbmcgc29mdCBjYXAgb2YgJHNvZnRfY2Fw
IgoJCWV4aXQgMwoJZmkKZmkKCmlmIFsgISAteiAiJENmbGFnIiBdOyB0aGVuCglpZiAhIGVj
aG8gJGhhcmRfY2FwID4gL3Byb2MvJCQvdGFzay8kJC9jcHVfcmF0ZV9oYXJkX2NhcDsgdGhl
bgoJCWVjaG8gIkVycm9yOiBzZXR0aW5nIGhhcmQgY2FwIG9mICRoYXJkX2NhcCIKCQlleGl0
IDMKCWZpCmZpCgppZiBbICEgLXogIiRuZmxhZyIgXTsgdGhlbgoJaWYgISByZW5pY2UgJG5p
Y2UgJCQgPiAvZGV2L251bGw7IHRoZW4KCQllY2hvICJFcnJvcjogc2V0dGluZyBuaWNlIG9m
ICRuaWNlIgoJCWV4aXQgMwoJZmkKZmkKCmV4ZWMgJCoK
--------------050405030407020507070308--
