Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269750AbUJMQv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbUJMQv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269748AbUJMQv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:51:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55761 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269750AbUJMQvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:51:19 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
Content-Type: text/plain
Message-Id: <1097686095.6538.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 12:48:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 

Ingo, here's the data from an 87 million sample run (about 24 hours) of
my jackd test.  Note the 1292 usec outlier.  This is definitely not
latency trace overhead as it was disabled.  I suspect either the
rt_garbage_collect or journal_clean_checkpoint_list code path is
responsible.

Delay   # samples
-----   ---------
0       86798124
1       122
2       113
3       118
4       109
5       96
6       78
7       66
8       66
9       51
10      52
11      41
12      39
13      43
14      43
15      30
16      17
17      18
18      28
19      17
20      18
21      16
22      19
23      19
24      19
25      15
26      26
27      13
28      13
29      10
30      17
31      19
32      12
33      12
34      17
35      7
36      16
37      13
38      7
39      10
40      9
41      9
42      9
43      8
44      11
45      18
46      12
47      13
48      6
49      12
50      12
51      13
52      8
53      11
54      14
55      5
56      5
57      11
58      8
59      11
60      8
61      5
62      11
63      8
64      9
65      11
66      9
67      8
68      8
69      8
70      8
71      8
72      11
73      10
74      10
75      8
76      2
77      7
78      4
79      9
80      5
81      4
82      2
83      7
84      6
85      1
86      7
87      5
88      10
89      7
90      3
91      7
92      7
93      7
94      1
95      7
96      5
97      7
98      2
99      3
100     3
101     4
102     4
103     4
104     5
105     3
106     5
107     2
108     4
109     1
110     2
111     2
112     3
113     2
115     1
116     3
117     2
118     3
119     3
120     1
121     2
122     2
123     2
124     1
127     1
128     2
129     2
130     2
133     1
135     1
139     1
141     2
145     1
147     1
152     1
156     1
169     1
173     1
177     1
187     1
194     2
233     1
242     1
290     1
352     1
1292    1

Lee


