Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRADWzh>; Thu, 4 Jan 2001 17:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRADWz2>; Thu, 4 Jan 2001 17:55:28 -0500
Received: from hermes.mixx.net ([212.84.196.2]:35844 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129523AbRADWzR>;
	Thu, 4 Jan 2001 17:55:17 -0500
Message-ID: <3A54FEA8.F667F61B@innominate.de>
Date: Thu, 04 Jan 2001 23:52:24 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <6740000.978629925@tiny> <Pine.LNX.4.10.10101040958310.15597-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'd rather just change the rule that "writepage()" will clear the dirty
> bit itself and always unlock (and "1" just to inform the upper layers that
> the page cannot be thrown away).

Change to that rule or from?  I *think* you just said:

  - If ->writepage successfully starts writeout on the page it clears
the dirty bit and returns 0

  - If not successful, ->writepage unlocks the page and return 1

Who is going to be responsible for checking that the page dirty bit was
really set, and what will happen if it wasn't?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
