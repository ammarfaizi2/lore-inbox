Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSIWGuZ>; Mon, 23 Sep 2002 02:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbSIWGuZ>; Mon, 23 Sep 2002 02:50:25 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:7304 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264888AbSIWGuY>;
	Mon, 23 Sep 2002 02:50:24 -0400
Message-ID: <1032764130.3d8ebae220908@kolivas.net>
Date: Mon, 23 Sep 2002 16:55:30 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Daniel Jacobowitz <dan@debian.org>, Andrew Morton <akpm@digeo.com>,
       Ville Herva <vherva@niksula.hut.fi>,
       Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>, gcc@gcc.gnu.org,
       Robert Love <rml@tech9.net>
Subject: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of those 2.96 compilers snuck in (my poor use of autocomplete). I take back
all the previous data and submit accurate ones, and apologise profusely for
ruining the signal to noise ratio on this list

To rehash what the last results were _supposed_ to be and what these are. I have
identical config 2.5.38 kernels compiled with either gcc2.95.3 or gcc3.2. Then I
run these two kernels through a contest benchmark (http://contest.kolivas.net)
using ONLY gcc2.95.3 to run the benchmark.

Kernel                  Time            CPU
NoLoad:
2.5.38                  68.25           99%
2.5.38-gcc32            67.28           99%
Process Load:
2.5.38                  71.60           95%
2.5.38-gcc32            70.86           94%
IO Half Load:
2.5.38                  81.26           90%
2.5.38-gcc32            88.11           82%
IO Full Load:
2.5.38                  170.21          42%
2.5.38-gcc32            230.77          30%
Mem Load:
2.5.38                  104.22          70%
2.5.38-gcc32            104.97          70%

This time only the IO loads showed a statistically significant difference.

Terribly sorry about that previous mess


Full logs:

2.5.38 (with gcc2.95.3)
noload Time: 68.25  CPU: 99%  Major Faults: 204613  Minor Faults: 255906
process_load Time: 71.60  CPU: 95%  Major Faults: 204019  Minor Faults: 255238
io_halfmem Time: 81.26  CPU: 90%  Major Faults: 204019  Minor Faults: 255325
Was writing number 4 of a 112Mb sized io_load file after 90 seconds
io_fullmem Time: 170.21  CPU: 42%  Major Faults: 204019  Minor Faults: 255272
Was writing number 6 of a 224Mb sized io_load file after 194 seconds
mem_load Time: 104.22  CPU: 70%  Major Faults: 204120  Minor Faults: 256271

2.5.38 (with gcc 3.2)
noload Time: 67.28  CPU: 99%  Major Faults: 205108  Minor Faults: 256153
process_load Time: 70.86  CPU: 94%  Major Faults: 204019  Minor Faults: 254983
io_halfmem Time: 88.11  CPU: 82%  Major Faults: 204019  Minor Faults: 255110
Was writing number 5 of a 112Mb sized io_load file after 99 seconds
io_fullmem Time: 230.77  CPU: 30%  Major Faults: 204019  Minor Faults: 254998
Was writing number 11 of a 224Mb sized io_load file after 303 seconds
mem_load Time: 104.97  CPU: 70%  Major Faults: 204208  Minor Faults: 255956

Con.
