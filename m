Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUALJAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUALJAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:00:17 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:52360
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S266084AbUALJAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:00:12 -0500
Message-ID: <400261C9.5000505@winischhofer.net>
Date: Mon, 12 Jan 2004 09:58:49 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net> <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 10 Jan 2004, Thomas Winischhofer wrote:
> 
>>The whole framebuffer stuff in 2.6 is ancient. (Look at the file dates.)
> 
> 
> Note that the fb stuff is ancient because it's basically not maintained as 
> far as I'm concerned.

Erm, well, _I_ know. But I assume you meant this message mainly for the 
public.

> I'm sorry, but this i show it is.  The fbcon people have been changing 
> interfaces faster than they have been fixing bugs in the code. Together

You tell me. I actually stopped adapting sisfb for a couple of months 
during the 2.5 development cycle - I could not keep up with the speed of 
substantial changes either.

> with the fact that most of the development seems to happen in outside 
> trees, and nobody ever sends me fixes relative to the released tree, this 
> makes for a pretty bad situation.
> 
> I really think that development should happen in the regular tree, or at 
> least be synched up in reasonable chunks THAT DO NOT BREAK everything.
> 
> I realize that some fb developers seem to disagree with me, but the fact 
> is, the way things are done now, fb will _always_ be broken. Most people 
> for whom the standard kernel works will never test the fb development 
> trees, so those trees will never get any amount of reasonable testing. As 
> a result, they WILL be buggy, and synching with them WILL be painful as 
> hell.

Isn't a large part of the fbcon/dev stuff in current 2.6 broken anyway? 
Could it become worse by merging James' current changes? But I guess 
this question - as well as the rest of your message - is for James to 
answer.

If the lastest and greatest of the fbdev stuff isn't merged with 2.6.2, 
I will revert the interface changes in sisfb and send a patch which 
works with the then-current vanilla kernel.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



