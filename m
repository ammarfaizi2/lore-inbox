Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271935AbRIQRUq>; Mon, 17 Sep 2001 13:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271931AbRIQRUn>; Mon, 17 Sep 2001 13:20:43 -0400
Received: from ns.ithnet.com ([217.64.64.10]:20744 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271918AbRIQRUE>;
	Mon, 17 Sep 2001 13:20:04 -0400
Date: Mon, 17 Sep 2001 19:20:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010917192022.313ddd5f.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109170942161.8900-100000@penguin.transmeta.com>
In-Reply-To: <20010917183433.5b992e74.skraw@ithnet.com>
	<Pine.LNX.4.33.0109170942161.8900-100000@penguin.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001 09:46:28 -0700 (PDT) Linus Torvalds
<torvalds@transmeta.com> wrote:

> "Looks cleaner" is very important for me for maintenance reasons - having
> behaviour that you cannot explain tends to result in more and more ad-hoc
> hacks over time, and it just tends to get worse and worse.

Agreed.

> However, at the same time I'd really like to hear about improved
> behaviour, not just "feels the same". And certainly not "(maybe even
> worse.."

Hm, sorry for that. But that's what I see. Maybe the problem is now on a
different field.

> The problematic part is that I suspect that _because_ there's a lot of
> inactive pages, the VM layer won't even try to age the active ones.
> Which will result in the inactive pages being re-circulated reasonably
> quickly..

Do you think this re-circulation is _fast_ in current code? Maybe performance
loss comes from this point?

BTW: I tried Andrea's brand new patch and have to admit it has a _big_
performance gain, though I understand you dislike the design very much. 

Regards,
Stephan
