Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDTWPH>; Fri, 20 Apr 2001 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDTWO4>; Fri, 20 Apr 2001 18:14:56 -0400
Received: from [212.159.14.227] ([212.159.14.227]:8920 "HELO
	warrior-outbound.servers.plus.net") by vger.kernel.org with SMTP
	id <S132053AbRDTWOq>; Fri, 20 Apr 2001 18:14:46 -0400
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
In-Reply-To: <3ADB69BF.7040305@reutershealth.com>
	<Pine.GSO.4.05.10104161622110.17365-100000@pipt.oz.cc.utah.edu>
	<20010416205556.A22960@thyrsus.com>
From: Adam Sampson <azz@gnu.org>
Organization: The Campaign For The Writing Of "a lot" As Two Words
Content-Type: text/plain; charset=US-ASCII
Date: 20 Apr 2001 00:20:11 +0100
In-Reply-To: <20010416205556.A22960@thyrsus.com>
Message-ID: <87itk04gus.fsf@cartman.azz.us-lot.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> If there were already a library in ths stock Python distribution to
> digest .Xdefaults files I might consider this.  Perhaps I'll write
> one.

No, please don't! .Xdefaults files as loaded by xrdb can contain cpp
directives which can depend on the arguments given to xrdb ("xrdb
-DBIGTERM .Xdefaults", for instance), so you can't assume that what
you read from .Xdefaults is the user's setup, even if you emulate
cpp. You also shouldn't assume that the user's HOME is on the machine
where they loaded their resources from (suppose I start an X session
on my workstation, then ssh over to a server and run CML2; it would
then read server:~/.Xdefaults rather than workstation:~/.Xdefaults).
It's much more sensible to use the normal X mechanisms for reading
resources from the X server.

CML2 looks good---keep up the good work.

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
