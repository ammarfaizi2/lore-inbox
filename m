Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTAVBJ5>; Tue, 21 Jan 2003 20:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTAVBJ5>; Tue, 21 Jan 2003 20:09:57 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:20194 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267155AbTAVBJz>;
	Tue, 21 Jan 2003 20:09:55 -0500
Date: Wed, 22 Jan 2003 01:19:00 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.4 VM Documentation - Take 3
Message-ID: <Pine.LNX.4.44.0301212359350.2402-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the third draft at a pair of papers aimed at documenting fully how
the 2.4 VM functions. I have made a large number of additions and
corrections so I felt another release would not hurt even if I still have
a few chapters to go. The most notable change is the introduction of a
chapter on the boot memory allocator. The full list of changes as best as
I can remember is listed at the end of this mail.

It can be found in the various formats at

Understanding the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Code Commentary on the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/code
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Any and all comments and corrections, especially on the bootmem allocator,
are welcome. If there is some section that you feel is not covered in
adequate detail or is omitted entirely, email me and I'll see what can be
done.

>> Fullish list of changes, can't remember them all :-/ <<

o Added a chapter description how the boot memory allocator works

o Added an explanation on the difference between mm_users and mm_count

o Fixed the explanation on pages_min, pages_low and pages_high. The
  language was quite confusing the way it was and open to misinterpretation

o Added sections on exception handling and how it applies to copying
  to/from userspace. Thanks go to Ingo Oeser for highlighting the
  importance and clarifying exactly how it worked to me (Thanks Ingo!)

o Large number of grammar and spelling mistakes, thanks to all who sent
  corrections as I am useless at proof reading this document now, the list
  of people is too large to list

o Corrected a part of the buddy allocator code commentary where a typo
  reversed the meaning of __GFP_WAIT

o Fixed a section where it is explained why 64GiB is an impractical
  amount of memory because of ZONE_NORMAL pressure. I calculated the
  amount of memory needed for mem_map wrong (Thank you Jean Francois Martinez)

o Fixed some call graphs where the order when traversed depth-first did
  not match what was in the code due to a bug in gengraph. New release of
  gengraph is out which works with recent 2.5 kernels and fixes the
  traversals

o Various other bits and pieces I can't recall

-- 
Mel Gorman				| "Documentation is like sex: when it is
MSc Student, University of Limerick	| good, it is very, very good and when
http://www.csn.ul.ie/~mel		| it is bad, it is better than nothing"
							-- Dick Brandon






