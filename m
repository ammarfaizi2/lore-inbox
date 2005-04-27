Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVD0VMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVD0VMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVD0VMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:12:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:63438 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S262017AbVD0VMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:12:16 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4270001F.8020504@s5r6.in-berlin.de>
Date: Wed, 27 Apr 2005 23:11:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
References: <20050417195706.GD3625@stusta.de>	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>	 <1113939827.6277.86.camel@laptopd505.fenrus.org>	 <42657F7C.8060305@s5r6.in-berlin.de>	 <1113981989.6238.30.camel@laptopd505.fenrus.org>	 <426683E9.4080708@s5r6.in-berlin.de> <1114029144.5085.20.camel@kino.dennedy.org>
In-Reply-To: <1114029144.5085.20.camel@kino.dennedy.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.508) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Dennedy wrote on 2005-04-20:
> There are technical
> merits for removal of the external symbols that I accept. I also accept
> that we have no way of maintaining any sort of stable subsystem for
> external projects we are not aware of or who are not communicating with
> us about their requirements (it goes beyond just a stable interface).
...
> I vote to remove external symbols not used by the Linux1394.org modules
> or the module at http://sourceforge.net/projects/video-2-1394/

Nobody else posted specific requirements so far. So let's clean up the 
API. How about this:
  - Determine a date or event at which unused symbols and functions will
    vanish. ("Unused": Not used by the mainline drivers and video-2-1394
    or any other project of similar scope of which the linux1394
    maintainers are informed soon enough.)
  - Add an according entry to Documentation/feature-removal-schedule.txt.
  - Add warning comments next to obsolete EXPORT_SYMBOLs. Add warning
    printks to obsolete functions? (If there are any.)
Are there proposals for a date? How about end of June?
-- 
Stefan Richter
-=====-=-=-= -=-- ==-==
http://arcgraph.de/sr/
