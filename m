Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVARCpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVARCpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVARCpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:45:33 -0500
Received: from opersys.com ([64.40.108.71]:45578 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261217AbVARCpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:45:30 -0500
Message-ID: <41EC7A03.10307@opersys.com>
Date: Mon, 17 Jan 2005 21:52:51 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home> <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501180152410.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501180152410.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> An additional comment about the order of events. What you're doing in 
> lockless_reserve is bogus anyway. There is no single correct time to 
> write into the event. By artificially synchronizing event order and event 
> time you only cheat yourself. You either take it into account during 
> postprocessing that events can be interrupted or the time stamp doesn't 
> seem to be that important, but there is nothing you can do during the 
> recording of the event except of completely disabling interrupts.

Correct and like I said before, we are dropping the lockless scheme.
Ergo, disabling interrupts we will.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
