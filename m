Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291354AbSBME73>; Tue, 12 Feb 2002 23:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291373AbSBME7J>; Tue, 12 Feb 2002 23:59:09 -0500
Received: from c37690.carlnfd1.nsw.optusnet.com.au ([203.164.24.124]:14319
	"EHLO cskk.homeip.net") by vger.kernel.org with ESMTP
	id <S291354AbSBME7F>; Tue, 12 Feb 2002 23:59:05 -0500
Date: Wed, 13 Feb 2002 16:00:10 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Mark Swanson <swansma@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Terrehon Bowden <terrehon@pacbell.net>,
        Bodo Bauer <bb@ricochet.net>, Jorge Nerin <comandante@zaralinux.com>
Subject: Re: RFC: /proc key naming consistency
Message-ID: <20020213160009.A7937@amadeus.home>
Reply-To: cs@zip.com.au
In-Reply-To: <20020213030047.8B1FB2257B@www.webservicesolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213030047.8B1FB2257B@www.webservicesolutions.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:50 12 Feb 2002, Mark Swanson <swansma@yahoo.com> wrote:
| I would like to hear people's opinions on making the keys in the /proc 
| hierarchy consistent wrt the space character. The current Linux 
| Documentation/filesystems.proc.txt does not suggest any standard naming 
| conventions. F.E. cat /proc/cpuinfo 
| (partial list)
| 
| cpu family      : 5
| model           : 9
| model name      : AMD-K6(tm) 3D+ Processor
| stepping        : 1
| cpu MHz         : 400.907
| cache size      : 256 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| 
| Notice the space between "cpu" and "MHz", or "cpu" and "family" yet there is 
| no space between "fdiv" and "bug" (_).
| 
| The reason I think NOT using a space is a good idea because it makes life 
| easier for developers parsing /proc entries. Specifically, Java developers 
| could use /proc/cpuinfo as a property file, but the space in the 'key' breaks 
| java.util.Properties.load(). 

Personally, I have LONG wished all /proc/* entries were shell parsable values, eg:

	cpu_family=5
	model=9
	model_name='AMD-K6(tm) 3D+ Processor'

etc. The amound of userland parsing code this would obviate must be quite
large, and it certainly would make simple scripts to do things with the
values much easier.

instead, there are all these "pretty" files, with formatting code that
properly belongs in userland tools residing in the kernel (yes, mostly
just printf but still).

Flame on dudes,
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

They call me a bummer and a gin-sop,too....but what care I for praise!
	- Bob Dylan.   "The days of '49"
