Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWKLPR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWKLPR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932930AbWKLPR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:17:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:53105 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932929AbWKLPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:17:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=uWm1utgX62P0X3j9oSMcwMshJPp5MbZGxDxhXIuUfc6W9tpVHIbQ2Jqi9G3qDthFrfHI8VKZ4dXpyWGuqXDCbg6Z/88LPd0hqA4h9vvS/4/E7Vcn75LsP+fiuLuTXUB/YiebcmQH8vDN1qcA7UpSXtlqfGUAK7G7B3pwBQ9cNZA=
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC PATCH] RFkill - Add support for input key to control wireless radio
Date: Sun, 12 Nov 2006 16:17:38 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org
References: <200611121548.56908.IvDoorn@gmail.com> <200611121613.46286.oliver@neukum.org>
In-Reply-To: <200611121613.46286.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121617.38430.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 November 2006 16:13, Oliver Neukum wrote:
> Am Sonntag, 12. November 2006 15:48 schrieb Ivo van Doorn:
> > If the input device has been opened, rfkill will send the signal to
> > userspace and do nothing further. The user is in charge of controlling
> > the radio.
> 
> As turning off the radio is relevant to safety eg. in aircraft, hospitals,
> etc., potentially ignoring the button is questionable.

True, that is why the default behavior is to listen to the button and change
the radio status. Only when the input device is opened the button is ignored.
But changing the radio status, and then reporting it to the user might also
not be what the user wants, he might want to execute some commands while
the radio is still enabled before disabling the radio.

Ivo
