Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315221AbSD2WU2>; Mon, 29 Apr 2002 18:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSD2WU1>; Mon, 29 Apr 2002 18:20:27 -0400
Received: from jalon.able.es ([212.97.163.2]:25823 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315221AbSD2WU1>;
	Mon, 29 Apr 2002 18:20:27 -0400
Date: Tue, 30 Apr 2002 00:20:19 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading and physical/logical CPU identification
Message-ID: <20020429222019.GA1732@werewolf.able.es>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7DF0@orsmsx111.jf.intel.com> <200204292017.PAA25836@popmail.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.29 Andrew Theurer wrote:
>
>> > I would very much like to believe that in this configuration,
>> > I am only
>> > running on 2 physical, 4 logical processors, but I am getting a 31%
>> > improvement (netbench) when hyperthreading is enabled.  Thats
>> > why I want to
>> > confirm I am really only using 2 physical, 4 logical
>> > processors.  Is there
>> > any way I can do this? (dmesg? /proc/cpuinfo?)
>>
>> Well the two alternatives are, either A) turning on hyperthreading enabled
>> the two virtual processors or B) turning on hyperthreading somehow enabled
>> the other two processors, right?
>>

I think you should post a more specific "this vs. that" comparison.
Guessing...

If you refer to:
- No hypethreading, box sees 2 processors, performance is 100%
- Hyperthreading active, box sees 4 processors, perf is _only_ 130%,
  instead of 200%.

that is perfectly true. Each hyperthreaded pair of processors does
not perform like 2 independent ones, the share cache and other internal
things. So the usual performance improvement on a FOster Xeon is not
200%, but in the order of that 130% you get. Hyperthreading is like
'poor man' SMP.

But perhaps you alredy know all this and your question was following
other paths...

I will put my hands on a dual Xeon SuperMicro system, and will make
more tests, in a week or so...

Hope this helps.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam7 #1 SMP jue abr 25 00:19:56 CEST 2002 i686
