Return-Path: <linux-kernel-owner+w=401wt.eu-S1751747AbXAQHvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXAQHvf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 02:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXAQHvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 02:51:35 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:35488 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbXAQHve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 02:51:34 -0500
Message-ID: <45ADD52C.50105@bull.net>
Date: Wed, 17 Jan 2007 08:50:04 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net> <45ACEBDF.60602@redhat.com> <20070116154054.GA21786@elte.hu> <45AD0F70.30808@redhat.com> <20070116175021.GA9778@elte.hu>
In-Reply-To: <20070116175021.GA9778@elte.hu>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 08:59:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 08:59:50,
	Serialize complete at 17/01/2007 08:59:50
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> * Ulrich Drepper <drepper@redhat.com> wrote:
> 
>>> what do you mean by that - which is this same resource?
>> From what has been said here before, all futexes are stored in the 
>> same list or hash table or whatever it was.  I want to see how that 
>> code behaves if many separate processes concurrently use futexes.
> 
> futexes are stored in the bucket hash, and these patches do not change 
> that. The pi-list that was talked about is per-futex. So there's no 
> change to the way futexes are hashed nor should there be any scalability 
> impact - besides the micro-impact that was measured in a number of ways 
> - AFAICS.

Yes, that's completely right !

-- 
Pierre
