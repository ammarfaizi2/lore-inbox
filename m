Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUBTU7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUBTU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:59:18 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:64984 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261329AbUBTU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:59:11 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 20 Feb 2004 15:57:33 -0500
Subject: Re: stty utf8
X-Originating-Ip: 172.198.79.23
X-Originating-Server: ws3-1.us4.outblaze.com
Message-Id: <20040220205733.C900F1535E6@ws3-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: I didn't have legacy hardware terminals in mind.
I was thinking more of a software terminal written from
scratch in utf-8 filesystems world.]

 > > Done that way, Jamie's delete example is
> > backspace-space-backspace and remove sizeof(wchar_t)
> > from the input.
 
> You could store wchar_t in the terminal queue, but what would be the
> point?  Removing a UTF-8 character from the input is _trivial_.
 
> > Ok, it takes more space than operating on the utf-8
> > encoding directly, but otherwise why not?
 
> Because there's no point.

Ie the convenience of iterating over a fixed size
character encoding in the terminal queue is negated
by other costs (legacy 8-bit filesystem support,
utf-8 control characters, et al)?

(I caught the discussion further down after posting.)

I'm spiritually with the "abort" people on this issue,
any opportunity to stab locale-overloaded character
values and arcane character encodings with shift
states in the heart is not to be passed up. "Every
character in every language has a unique value
everywhere that it is used, or we are not finished
fixing this yet."

But I agree with Linus that it is an admin policy
issue, not a kernel issue.

Thanks for your time,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

