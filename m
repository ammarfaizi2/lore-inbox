Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbSLSEhM>; Wed, 18 Dec 2002 23:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbSLSEhM>; Wed, 18 Dec 2002 23:37:12 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:2987 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267529AbSLSEhL>;
	Wed, 18 Dec 2002 23:37:11 -0500
Message-ID: <1040273106.3e014ed281e46@kolivas.net>
Date: Thu, 19 Dec 2002 15:45:06 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: [BENCHMARK] scheduler tunables with contest - child_penalty
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are contest results with 2.5.52-mm1 and different child_penalty settings
(default is 95):

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           40.0    180     0       0       1.10
chi_pen75 [3]           40.0    180     0       0       1.10
2.5.52-mm1 [8]          39.7    180     0       0       1.10

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           37.0    194     0       0       1.02
chi_pen75 [3]           37.0    193     0       0       1.02
2.5.52-mm1 [7]          36.9    194     0       0       1.02

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           54.0    130     15      64      1.49
chi_pen75 [3]           52.9    132     15      61      1.46
2.5.52-mm1 [7]          49.0    144     10      50      1.35

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           51.8    159     1       10      1.43
chi_pen75 [3]           50.9    160     1       10      1.41
2.5.52-mm1 [7]          55.5    156     1       10      1.53

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           73.1    120     1       8       2.02
chi_pen75 [3]           84.5    110     1       8       2.33
2.5.52-mm1 [7]          77.4    122     1       8       2.14

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           117.7   88      22      26      3.25
chi_pen75 [3]           109.4   96      20      24      3.02
2.5.52-mm1 [7]          80.5    108     10      19      2.22

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           108.1   92      21      26      2.99
chi_pen75 [3]           105.6   106     19      25      2.92
2.5.52-mm1 [7]          60.1    131     7       18      1.66

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           50.6    149     5       6       1.40
chi_pen75 [3]           50.7    150     5       6       1.40
2.5.52-mm1 [7]          49.9    149     5       6       1.38

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           44.1    166     0       9       1.22
chi_pen75 [3]           43.6    167     0       9       1.20
2.5.52-mm1 [7]          43.8    167     0       9       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
chi_pen50 [3]           108.1   72      37      2       2.99
chi_pen75 [3]           89.3    89      36      2       2.47
2.5.52-mm1 [7]          71.1    123     36      2       1.96

That sure changes things somewhat.

Con
