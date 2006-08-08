Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWHHNR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWHHNR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHHNR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:17:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:34177 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932266AbWHHNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:17:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fpezud5L3v5HmqtZsxCGf3EmW+knR4hRyhmpiICXijMAvhh42CtAkjUe2WaVGTwj4KLc7fSj6CDNZtoAT8jX7ufbaeiqAMWaK4ew2Zq4abWoA7pyCoVD6foYOyWu4mC+bn+8xtWav0WAOOadhD9G+/Qx3fPFSkSKNxDLFODEDto=
Message-ID: <41840b750608080617t3f20a9c9m77fa5276fb5e5f3@mail.gmail.com>
Date: Tue, 8 Aug 2006 16:17:25 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 08/12] hdaps: Add explicit hardware configuration functions
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060808121619.GF4540@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492822826-git-send-email-multinymous@gmail.com>
	 <20060808121619.GF4540@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:

> >  static int needs_calibration = 0;
> Unneccessary initializer.

OK, though I would prefer to differentiate "initial value is 0" from
"initial value doesn't matter".


> > + * hdaps_set_fake_data_mode - enable or disable EC test mode, which fakes
> > + * accelerometer data using an incrementing counter.
> > + * Returns zero on success and negative error code on failure.  Can sleep.
> > + */
>
> Why do we want to have fake mode? I see it is useful for debugging,
> but?

It's useful for debugging userspace too. Apps like the hdapsd daemon
can use it to figure out how often and how regularly they get fresh
readouts, and whether they often miss readouts.


> > +/*
> > + * hdaps_check_ec - checks something about the EC.
> > + * Follows the clean-room spec for HDAPS; we don't know what it means.
> > + * Returns zero on success and negative error code on failure.  Can sleep.
> > + */
>
> URL for spec?

http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html, it's at the
top of the original file.


> What happens when we delete this one?

No idea, nor a way to check (on all relevant models). We've always
done it, this patch just does it a bit more explicitly and by
correctly following the H8S LPC protocol.

OK on all other comments to patches 06-08.

  Shem
