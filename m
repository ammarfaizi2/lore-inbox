Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUBJHe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBJHe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:34:26 -0500
Received: from khe-mailhub1.eigner.com ([194.120.231.246]:20594 "EHLO
	khe-mailhub1.eigner.com") by vger.kernel.org with ESMTP
	id S265694AbUBJHeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:34:23 -0500
Message-ID: <4028895C.4010101@gmx.de>
Date: Tue, 10 Feb 2004 08:33:48 +0100
From: Andreas Fester <Andreas.Fester@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [2.6 PATCH] persist qconf options
References: <4028075E.1070809@gmx.de> <Pine.LNX.4.58.0402100050230.7851@serv>
In-Reply-To: <Pine.LNX.4.58.0402100050230.7851@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2004 07:33:46.0512 (UTC) FILETIME=[37BC0900:01C3EFA8]
X-agile-MailScanner-Information: Please contact the ISP for more information
X-agile-MailScanner: Found to be clean
X-agile-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.1, required 5, IN_REP_TO -0.50,
	QUOTED_EMAIL_TEXT -0.48, REFERENCES -0.50, REPLY_WITH_QUOTES -0.50,
	USER_AGENT_MOZILLA_UA 0.00, X_ACCEPT_LANG -0.10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

thanks for the feedback :-)

>>@@ -1145,6 +1162,10 @@
>>  	menuList->updateListAll();
>>  }
>>
>>+bool ConfigMainWindow::getShowAll() {
>>+	return configList->showAll;
>>+}
>>+
>>  void ConfigMainWindow::setShowDebug(bool b)
>>  {
>>  	if (showDebug == b)
> 
> 
> All these access functions are really not neccessary.

Well, I think in the sense of an Object Oriented interface
with getter/setter methods they probably *do* make sense ...

> If we change this I'd like to see this done properly. First all the
> settings business should be moved into a small helper class, so that there

Agreed. I thought about something similar, but simply started to
hack some code last night ;-)

> are not x number of new arguments to the ConfigList constructor. The

Agreed. The four additional arguments is what I mostly dislike with my
solution.

> saving of the settings should be connected to aboutToQuit().

Ok.

> Bonus points if you also save the list mode and the position of the
> splitter. :)

Lets see if I can win them :-)

Thanks,

	Andreas

-- 
Andreas Fester
mailto:Andreas.Fester@gmx.de
WWW: http://littletux.homelinux.org
