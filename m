Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAYWuK>; Thu, 25 Jan 2001 17:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAYWuB>; Thu, 25 Jan 2001 17:50:01 -0500
Received: from hermes.mixx.net ([212.84.196.2]:52998 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129169AbRAYWtv>;
	Thu, 25 Jan 2001 17:49:51 -0500
Message-ID: <3A70AD03.1147641@innominate.de>
Date: Thu, 25 Jan 2001 23:47:31 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.31.0101171932460.31432-100000@localhost.localdomain> <qwwk87tclpu.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> As of 2.4.1-pre we pin the pages by increasing the page count for
> locked segments. No special list needed.

Sure no special list is needed.  But without a special list to park
those pages on they will just circulate on the active/inactive lists,
wasting CPU cycles and trashing cache.  A special list would be an
improvement, but is no burning issue.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
