Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLZOxm>; Thu, 26 Dec 2002 09:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSLZOxm>; Thu, 26 Dec 2002 09:53:42 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:33185
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S261409AbSLZOxj> convert rfc822-to-8bit; Thu, 26 Dec 2002 09:53:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: scott thomason <scott@thomasons.org>
Reply-To: scott@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
Date: Thu, 26 Dec 2002 09:01:54 -0600
User-Agent: KMail/1.4.3
References: <200212200850.32886.conman@kolivas.net> <200212251829.33553.conman@kolivas.net> <200212251017.41813.scott@thomasons.org>
In-Reply-To: <200212251017.41813.scott@thomasons.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212260901.54212.scott@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 December 2002 10:17 am, scott thomason wrote:
> Yes, sorry. The values listed concisely are correct, IOW:
>
> child_penalty: 95
> exit_weight: 3
> interactive_delta: 4
> max_sleep_avg: 2000
> max_timeslice: 200
> min_timeslice: 20
> parent_penalty: 100
> prio_bonus_ratio: 25
> starvation_limit: 3000
>
> Now I need to fire up a ConTest, then off to Christmas with Grandma
> and the kids! Merry Christmas to all!

Here is the detailed ConTest data, first for 2.5.52-mm2 with the 
default tunables, then with the settings listed above. Two comments 
about how I use ConTest so you don't wig out about low numbers: 1) I 
compile qmail with a tailored Makefile instead of the kernel;  2) I 
limit the size of the tempfile to 100MB (instead of the 1GB my setup 
would normally yield). On with the detailed data (sorry, I don't have 
the original *.logs to build the -r report):

Default tunables

noload Time: 18.82  CPU: 171%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368526  Minor Faults: 181377
process_load Time: 25.12  CPU: 125%  LoadRuns: 18  LoadCPU%: 74%  
Major Faults: 368526  Minor Faults: 181375
ctar_load Time: 32.73  CPU: 139%  LoadRuns: 206  LoadCPU%: 31%  Major 
Faults: 368527  Minor Faults: 181378
xtar_load Time: 30.51  CPU: 152%  LoadRuns: 79  LoadCPU%: 26%  Major 
Faults: 368528  Minor Faults: 181376
io_load Time: 37.13  CPU: 118%  LoadRuns: 125  LoadCPU%: 40%  Major 
Faults: 368524  Minor Faults: 181376
read_load Time: 31.20  CPU: 99%  LoadRuns: 1147  LoadCPU%: 99%  Major 
Faults: 368524  Minor Faults: 181377
list_load Time: 22.33  CPU: 151%  LoadRuns: 0  LoadCPU%: 4%  Major 
Faults: 368526  Minor Faults: 181376
mem_load Time: 39.70  CPU: 106%  LoadRuns: 88  LoadCPU%: 14%  Major 
Faults: 368533  Minor Faults: 183364
noload Time: 18.67  CPU: 171%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368527  Minor Faults: 181378
process_load Time: 20.57  CPU: 154%  LoadRuns: 10  LoadCPU%: 49%  
Major Faults: 368527  Minor Faults: 181377
ctar_load Time: 24.48  CPU: 195%  LoadRuns: 164  LoadCPU%: 20%  Major 
Faults: 368527  Minor Faults: 181381
xtar_load Time: 31.33  CPU: 141%  LoadRuns: 83  LoadCPU%: 24%  Major 
Faults: 368526  Minor Faults: 181376
io_load Time: 32.06  CPU: 154%  LoadRuns: 159  LoadCPU%: 55%  Major 
Faults: 368526  Minor Faults: 181377
read_load Time: 30.11  CPU: 103%  LoadRuns: 1044  LoadCPU%: 95%  Major 
Faults: 368527  Minor Faults: 181376
list_load Time: 19.49  CPU: 172%  LoadRuns: 0  LoadCPU%: 8%  Major 
Faults: 368527  Minor Faults: 181377
mem_load Time: 47.46  CPU: 102%  LoadRuns: 97  LoadCPU%: 11%  Major 
Faults: 369220  Minor Faults: 184244
noload Time: 18.56  CPU: 172%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368528  Minor Faults: 181376
process_load Time: 26.16  CPU: 120%  LoadRuns: 20  LoadCPU%: 77%  
Major Faults: 368525  Minor Faults: 181375
ctar_load Time: 68.20  CPU: 68%  LoadRuns: 428  LoadCPU%: 14%  Major 
Faults: 368525  Minor Faults: 181381
xtar_load Time: 28.97  CPU: 163%  LoadRuns: 85  LoadCPU%: 25%  Major 
Faults: 368527  Minor Faults: 181376
io_load Time: 29.25  CPU: 164%  LoadRuns: 126  LoadCPU%: 48%  Major 
Faults: 368526  Minor Faults: 181377
read_load Time: 31.03  CPU: 100%  LoadRuns: 1115  LoadCPU%: 97%  Major 
Faults: 368525  Minor Faults: 181377
list_load Time: 21.81  CPU: 155%  LoadRuns: 0  LoadCPU%: 8%  Major 
Faults: 368526  Minor Faults: 181377
mem_load Time: 47.05  CPU: 88%  LoadRuns: 96  LoadCPU%: 11%  Major 
Faults: 368552  Minor Faults: 181433


Tweaked tunables

noload Time: 18.62  CPU: 172%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368528  Minor Faults: 181384
process_load Time: 27.54  CPU: 114%  LoadRuns: 25  LoadCPU%: 81%  
Major Faults: 368527  Minor Faults: 181383
ctar_load Time: 27.53  CPU: 171%  LoadRuns: 181  LoadCPU%: 30%  Major 
Faults: 368528  Minor Faults: 181388
xtar_load Time: 32.61  CPU: 127%  LoadRuns: 74  LoadCPU%: 20%  Major 
Faults: 368525  Minor Faults: 181385
io_load Time: 42.57  CPU: 113%  LoadRuns: 204  LoadCPU%: 46%  Major 
Faults: 368527  Minor Faults: 181384
read_load Time: 22.66  CPU: 141%  LoadRuns: 312  LoadCPU%: 44%  Major 
Faults: 368527  Minor Faults: 181384
list_load Time: 21.63  CPU: 158%  LoadRuns: 0  LoadCPU%: 4%  Major 
Faults: 368526  Minor Faults: 181383
mem_load Time: 44.48  CPU: 96%  LoadRuns: 93  LoadCPU%: 12%  Major 
Faults: 368528  Minor Faults: 181402
noload Time: 18.70  CPU: 172%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368525  Minor Faults: 181385
process_load Time: 27.37  CPU: 115%  LoadRuns: 25  LoadCPU%: 82%  
Major Faults: 368527  Minor Faults: 181382
ctar_load Time: 73.84  CPU: 62%  LoadRuns: 498  LoadCPU%: 19%  Major 
Faults: 368525  Minor Faults: 181388
xtar_load Time: 25.15  CPU: 163%  LoadRuns: 58  LoadCPU%: 24%  Major 
Faults: 368527  Minor Faults: 181385
io_load Time: 35.49  CPU: 118%  LoadRuns: 112  LoadCPU%: 33%  Major 
Faults: 368525  Minor Faults: 181385
read_load Time: 23.11  CPU: 137%  LoadRuns: 517  LoadCPU%: 63%  Major 
Faults: 368525  Minor Faults: 181383
list_load Time: 21.61  CPU: 157%  LoadRuns: 0  LoadCPU%: 4%  Major 
Faults: 368528  Minor Faults: 181383
mem_load Time: 42.15  CPU: 130%  LoadRuns: 90  LoadCPU%: 13%  Major 
Faults: 368524  Minor Faults: 181466
noload Time: 18.95  CPU: 169%  LoadRuns: 0  LoadCPU%: 0  Major Faults: 
368526  Minor Faults: 181384
process_load Time: 27.44  CPU: 114%  LoadRuns: 24  LoadCPU%: 83%  
Major Faults: 368527  Minor Faults: 181384
ctar_load Time: 23.68  CPU: 191%  LoadRuns: 155  LoadCPU%: 16%  Major 
Faults: 368527  Minor Faults: 181388
xtar_load Time: 31.76  CPU: 137%  LoadRuns: 65  LoadCPU%: 23%  Major 
Faults: 368527  Minor Faults: 181386
io_load Time: 33.40  CPU: 123%  LoadRuns: 150  LoadCPU%: 45%  Major 
Faults: 368527  Minor Faults: 181385
read_load Time: 21.26  CPU: 147%  LoadRuns: 424  LoadCPU%: 57%  Major 
Faults: 368526  Minor Faults: 181384
list_load Time: 20.29  CPU: 167%  LoadRuns: 0  LoadCPU%: 4%  Major 
Faults: 368527  Minor Faults: 181383
mem_load Time: 51.10  CPU: 130%  LoadRuns: 98  LoadCPU%: 12%  Major 
Faults: 368596  Minor Faults: 181598


Finally, it crossed my mind that completely subjective monitoring of X 
jerkiness perhaps wasn't the most scientific way of measuring the 
interactive impact of the tunables. I'm no Evil Scientist, but I 
whipped up a perl script that I think accomplishes something close to 
capturing those statistics. It captures 1000 samples of what should 
be a precise .2 second delay (on an idle system it is, with a tiny 
bit of noise). 

Here's the script, along with some output produced while the system 
was under considerable load. Would something like this be worth 
developing further to help rigorously measure the interactive impact 
of the tunables? Or is there a flaw in the approach?


#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes qw/sleep time/;

my %pause = ();

for (my $x = 0; $x < 1000; $x++) {
  my $start = time();
  sleep(.2);
  my $stop = time();
  my $elapsed = $stop - $start;

  $pause{sprintf('%01.3f', $elapsed)}++;
}

foreach (sort(keys(%pause))) {
  print "$_:  $pause{$_}\n";
}

exit 0;


Sample output

time ./int_resp_timer.pl 
0.192:  1
0.199:  1
0.200:  10
0.201:  201
0.202:  53
0.203:  25
0.204:  22
0.205:  21
0.206:  34
0.207:  29
0.208:  29
0.209:  100
0.210:  250
0.211:  120
0.212:  35
0.213:  16
0.214:  17
0.215:  14
0.216:  9
0.217:  1
0.218:  3
0.219:  3
0.220:  1
0.222:  1
0.233:  1
0.303:  1
0.304:  1
0.385:  1

real	3m28.568s
user	0m0.329s
sys	0m1.260s

