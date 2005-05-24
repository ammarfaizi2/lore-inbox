Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVEXNZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVEXNZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVEXNXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:23:43 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:18318 "EHLO
	brmx1.boca.ssc.siemens.com") by vger.kernel.org with ESMTP
	id S262077AbVEXNPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:15:10 -0400
Message-ID: <2DA8F872430BE8469BF0F403A6103F9205D01B@stca20aa.bocc.icn.siemens.com>
From: "Bloch, Jack" <jack.bloch@siemens.com>
To: "'linux-kernel@vger.kernel.org.'" <linux-kernel@vger.kernel.org>
Subject: grpof question
Date: Tue, 24 May 2005 06:14:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C56061.FC07CDD2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C56061.FC07CDD2
Content-Type: text/plain;
	charset="iso-8859-1"

I hope that this list is the correct place. I ran a small test program with
compiled as follows


gcc -pg -g -o testit testit.c

I then ran the program and it created a gmon.out.

I ran gprof as follows gprof testit > testit.prof


All of my times are zero in the profiler. I have attached the testit.prof.


I'm running a SuSE 2.6 SLES 9 Kernel.

Any hints?   Please CC me directly.


Regards,


Jack



 <<testit.prof>> 

------_=_NextPart_000_01C56061.FC07CDD2
Content-Type: application/octet-stream;
	name="testit.prof"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="testit.prof"

Flat profile:

Each sample counts as 0.01 seconds.
 no time accumulated

  %   cumulative   self              self     total          =20
 time   seconds   seconds    calls  Ts/call  Ts/call  name   =20
  0.00      0.00     0.00       10     0.00     0.00  do_work
  0.00      0.00     0.00       10     0.00     0.00  proc_1

 %         the percentage of the total running time of the
time       program used by this function.

cumulative a running sum of the number of seconds accounted
 seconds   for by this function and those listed above it.

 self      the number of seconds accounted for by this
seconds    function alone.  This is the major sort for this
           listing.

calls      the number of times this function was invoked, if
           this function is profiled, else blank.
=20
 self      the average number of milliseconds spent in this
ms/call    function per call, if this function is profiled,
	   else blank.

 total     the average number of milliseconds spent in this
ms/call    function and its descendents per call, if this=20
	   function is profiled, else blank.

name       the name of the function.  This is the minor sort
           for this listing. The index shows the location of
	   the function in the gprof listing. If the index is
	   in parenthesis it shows where it would appear in
	   the gprof listing if it were to be printed.
=0C
		     Call graph (explanation follows)


granularity: each sample hit covers 4 byte(s) no time propagated

index % time    self  children    called     name
                0.00    0.00      10/10          proc_1 [2]
[1]      0.0    0.00    0.00      10         do_work [1]
-----------------------------------------------
                0.00    0.00      10/10          main [9]
[2]      0.0    0.00    0.00      10         proc_1 [2]
                0.00    0.00      10/10          do_work [1]
-----------------------------------------------

 This table describes the call tree of the program, and was sorted by
 the total amount of time spent in each function and its children.

 Each entry in this table consists of several lines.  The line with the
 index number at the left hand margin lists the current function.
 The lines above it list the functions that called this function,
 and the lines below it list the functions this one called.
 This line lists:
     index	A unique number given to each element of the table.
		Index numbers are sorted numerically.
		The index number is printed next to every function name so
		it is easier to look up where the function in the table.

     % time	This is the percentage of the `total' time that was spent
		in this function and its children.  Note that due to
		different viewpoints, functions excluded by options, etc,
		these numbers will NOT add up to 100%.

     self	This is the total amount of time spent in this function.

     children	This is the total amount of time propagated into this
		function by its children.

     called	This is the number of times the function was called.
		If the function called itself recursively, the number
		only includes non-recursive calls, and is followed by
		a `+' and the number of recursive calls.

     name	The name of the current function.  The index number is
		printed after it.  If the function is a member of a
		cycle, the cycle number is printed between the
		function's name and the index number.


 For the function's parents, the fields have the following meanings:

     self	This is the amount of time that was propagated directly
		from the function into this parent.

     children	This is the amount of time that was propagated from
		the function's children into this parent.

     called	This is the number of times this parent called the
		function `/' the total number of times the function
		was called.  Recursive calls to the function are not
		included in the number after the `/'.

     name	This is the name of the parent.  The parent's index
		number is printed after it.  If the parent is a
		member of a cycle, the cycle number is printed between
		the name and the index number.

 If the parents of the function cannot be determined, the word
 `<spontaneous>' is printed in the `name' field, and all the other
 fields are blank.

 For the function's children, the fields have the following meanings:

     self	This is the amount of time that was propagated directly
		from the child into the function.

     children	This is the amount of time that was propagated from the
		child's children to the function.

     called	This is the number of times the function called
		this child `/' the total number of times the child
		was called.  Recursive calls by the child are not
		listed in the number after the `/'.

     name	This is the name of the child.  The child's index
		number is printed after it.  If the child is a
		member of a cycle, the cycle number is printed
		between the name and the index number.

 If there are any cycles (circles) in the call graph, there is an
 entry for the cycle-as-a-whole.  This entry shows who called the
 cycle (as parents) and the members of the cycle (as children.)
 The `+' recursive calls entry shows the number of function calls that
 were internal to the cycle, and the calls entry for each member shows,
 for that member, how many times it was called from other members of
 the cycle.

=0C
Index by function name

   [1] do_work                 [2] proc_1

------_=_NextPart_000_01C56061.FC07CDD2--
