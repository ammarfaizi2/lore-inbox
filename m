Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWGGTsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWGGTsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWGGTse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:48:34 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:717 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932239AbWGGTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:48:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j2MqBoR/gntmblL55OnD3Xkkt/LDgicxMcZLtpZ8+G5lCvkNfgtd7QIUjw3v8676697zHnnqnWyup4eb9p382aDJIUIkgUO28K294vo4s64HiKQL/1s9EbqU+XIEw9tjcz97NnuBkfJzAJYM1BbeVmHQ50XteMuIHDcYlMq8kbw=
Message-ID: <ab2fc2a60607071248w2d348daap2f21045f9f35f477@mail.gmail.com>
Date: Fri, 7 Jul 2006 21:48:33 +0200
From: "Paul Fleischer" <paul.fleischer@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: IPv6 Flow Labels and options headers under Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been playing around with IPv6 flow labels on UDP under Linux.
When using flow labels on a socket, I seem unable to set the per-hop
options header on a per-packet basis. It works if I set the per-hop
options header while acquiring the flow label from the kernel. I am
wondering if Linux enforces the following from Appendix A of RFC2460:

"
   All packets belonging to the same flow must be sent with the same
   source address, destination address, and flow label.  If any of those
   packets includes a Hop-by-Hop Options header, then they all must be
   originated with the same Hop-by-Hop Options header contents
   (excluding the Next Header field of the Hop-by-Hop Options header).
"

Does anyone know if that is the case?

Regards,
Paul Fleischer
