Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWHHOxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWHHOxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHHOxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:53:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:36947 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932590AbWHHOxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:53:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOnnabxMP8QZxJMT9056KVXsuMQvWs71G2e9Mvuw3KGn1Q7gg5VHXF2PlpjTDscht5VZhjnEgOg4Ywl3kiAArxv9Om8cQSihaFLczteOFwzvupb/ooFbEIQ/pKRIjwab3cby3PG8GPbxgI3NV5Q3ZYzRKnqYwCYupyYT6UMvHps=
Message-ID: <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com>
Date: Tue, 8 Aug 2006 17:53:39 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Cc: "Pavel Machek" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060808134337.GF5497@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492543835-git-send-email-multinymous@gmail.com>
	 <20060807140721.GH4032@ucw.cz>
	 <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
	 <20060807182047.GC26224@atjola.homenet>
	 <20060808122234.GD5497@rhun.haifa.ibm.com>
	 <20060808125652.GA5284@ucw.cz>
	 <20060808131724.GE5497@rhun.haifa.ibm.com>
	 <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com>
	 <20060808134337.GF5497@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> > We may end up needing to lock away other subsystems (ACPI?) that
> > touch the same ports. Apparently not an issue right now, but could
> > change with new firmware. (http://lkml.org/lkml/2006/8/7/147)
>
> When (if) it becomes necessary to lock away other subsystems, the
> wrapper can be easily reintroduced.

It's an exported function, and we already have an out-of-tree module
(awaiting future submission once the dust clears about this series)
which relies on it.

See the LKML discussion, "Subject: tp_smapi conflict with IDE, hdaps",
and especially Alan Cox's sample code for this. (That got me
embarrassed into writing the rest of thinkpad_ec...)

  Shem
