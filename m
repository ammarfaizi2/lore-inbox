Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLLX40>; Tue, 12 Dec 2000 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129590AbQLLX4Q>; Tue, 12 Dec 2000 18:56:16 -0500
Received: from melvin.eunet.fi ([193.66.1.146]:31179 "EHLO melvin.eunet.fi")
	by vger.kernel.org with ESMTP id <S129552AbQLLX4C>;
	Tue, 12 Dec 2000 18:56:02 -0500
Message-ID: <3A36B3E5.CF9FC31D@jlaako.pp.fi>
Date: Wed, 13 Dec 2000 01:25:25 +0200
From: Jussi Laako <jussi@jlaako.pp.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Mutz <Marc@Mutz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM problem (2.4.0-test11)
In-Reply-To: <3A36A163.3F01277D@jlaako.pp.fi> <3A36ADB8.3CE36940@Mutz.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mutz wrote:
> 
> Just to not miss the obvious: You know about ulimit(3)?

Yes, but it doesn't stop deadlocks caused by kernel's VM system going
wild... I think that no matter what user process does, root should be always
able to stop it. User process should never be able to render whole system
unusable.

Hard memory limit per process doesn't stop this from happening, because it
depends overall system memory usage and allocation rate. It's completely
different if memory usage goes from 200 MB to 512 MB in 1 usec or 1 week.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
