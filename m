Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267485AbUBSS5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267481AbUBSSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:55:55 -0500
Received: from spf13.us4.outblaze.com ([205.158.62.67]:2983 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S267477AbUBSSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:54:22 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2004 13:53:47 -0500
Subject: Re: stty utf8
X-Originating-Ip: 172.197.154.129
X-Originating-Server: ws3-4.us4.outblaze.com
Message-Id: <20040219185347.A94A23CE24D@ws3-4.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an application that is taking input in utf-8,
if I want to search, compare, yada yada, I need
to convert to wchar_t first (for iswspace() et al),
then convert back to utf-8 for output (so grep et al
and operations on pathnames are not hosed by embedded
nul bytes in the output).

Why would not terminals do the same thing?

Done that way, Jamie's delete example is
backspace-space-backspace and remove sizeof(wchar_t)
from the input.

Ok, it takes more space than operating on the utf-8
encoding directly, but otherwise why not? All display
characters begin at the same offset from the
character before or after. It's up to the terminal
code to convert to/from utf-8 when talking to the rest
of the kernel.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

