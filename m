Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289312AbSAIJvV>; Wed, 9 Jan 2002 04:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288569AbSAIJvL>; Wed, 9 Jan 2002 04:51:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:29203 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289315AbSAIJu7>; Wed, 9 Jan 2002 04:50:59 -0500
Message-ID: <3C3C127A.8E7F1102@aitel.hist.no>
Date: Wed, 09 Jan 2002 10:50:50 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.43.0201081819060.23139-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
[...]
> Have we ever considered making rescheduling work like get_user? That is,
> make current->need_resched be a pointer, and if we need to reschedule,
> make it an INVALID pointer that causes us to fault and call schedule in
> its fault path?

Elegant perhaps, but now you take the time to do a completely
unnecessary
page fault when rescheduling.  This has a cost which is high on
some architectures.  But the point of rescheduling was to improve
interactive performance and io latency.  
Every page fault may have to check for this case.

Helge Hafting
