Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVBBXGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVBBXGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVBBXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:06:29 -0500
Received: from borg.st.net.au ([65.23.158.22]:664 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S262818AbVBBXGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:06:01 -0500
Message-ID: <42015CD3.60005@torque.net>
Date: Thu, 03 Feb 2005 09:05:55 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
Cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [patch libata-dev-2.6 1/1] libata: sync SMART ioctls with ATA
 pass thru spec (T10/04-262r7)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
<snip>
 > >
 > > -/* Temporary values for T10/04-262 until official values are
 > allocated */
 > > -#define	ATA_16		      0x85	/* 16-byte pass-thru
 > [0x85 == unused]*/
 > -#define	ATA_12		      0xb3	/* 12-byte pass-thru
 > [0xb3 == obsolete set limits command] */
 > > +/* Values for T10/04-262r7 */
 > > +#define	ATA_16		      0x85	/* 16-byte pass-thru */
 > > +#define	ATA_12		      0xa1	/* 12-byte pass-thru */
 >
 > Ehh are you sure that is correct? 0xa1 is the BLANK command, I would
 > hate to think there would be a collision like that.

That very point came up recently in a MMC meeting:
http://www.t10.org/ftp/t10/document.05/05-056r0.pdf

To confuse things further "ATA_16" is shown as opcode 0x98
in the latest draft of SPC-3 (rev 21c 15 January 2005)
http://www.t10.org/ftp/t10/drafts/spc3/spc3r21c.pdf [annex D.3.1].

Hopefully these matters will be sorted out at the next t10
meeting in March.

Doug Gilbert

