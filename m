Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281066AbRKHB1O>; Wed, 7 Nov 2001 20:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKHB1E>; Wed, 7 Nov 2001 20:27:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37384 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281066AbRKHB0p>; Wed, 7 Nov 2001 20:26:45 -0500
Message-ID: <3BE9DF48.20802@zytor.com>
Date: Wed, 07 Nov 2001 17:26:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: antirez <antirez@invece.org>
CC: David Ford <david@blue-labs.org>,
        "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu> <3BE9D7BD.7030308@blue-labs.org> <20011108021057.E568@blu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

antirez wrote:

> On Wed, Nov 07, 2001 at 07:54:21PM -0500, David Ford wrote:
> 
>>That doesn't solve anything if the data value includes ( or ).  It just 
>>avoids ' ' in the data value and adds complexity.
>>
> 
> Wrong, exampel of () in data:
> 
> ((data)(\(\)))
> 
> About the complexity. It only "looks" complex. But from the
> machine point of view it's very simple to parse.
> Note that the strong advantage of this isn't the quoting,
> you can quote anyway in 1000 different ways. The advantage
> is that data is structured and parsing does not rely on
> spaces or newlines, but just on ().
> With this syntax you can express data as complex and structured
> as you want but the parsing is still simple.
> 


You just changed spaces and newlines to ( and ) -- it doesn't really solve
anything unless you want three levels of nesting or more; in which case
you have *WAY* too much data in a single proc item.

	-hpa


