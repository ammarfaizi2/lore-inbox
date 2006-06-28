Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWF1KRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWF1KRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWF1KRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:17:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17287 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932538AbWF1KRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:17:05 -0400
Subject: Re: [PATCH] Keys: Allow in-kernel key requestor to pass auxiliary
	data to upcaller [try #2]
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <10777.1151489399@warthog.cambridge.redhat.com>
References: <15367.1151418456@warthog.cambridge.redhat.com>
	 <15078.1151417633@warthog.cambridge.redhat.com>
	 <10777.1151489399@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 12:17:01 +0200
Message-Id: <1151489821.3153.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + */
> +struct key *request_key_with_auxdata(struct key_type *type,
> +				     const char *description,
> +				     const char *callout_info,
> +				     void *aux)
> +{
> +	return request_key_and_link(type, description, callout_info, aux,
> +				    NULL, KEY_ALLOC_IN_QUOTA);
> +
> +} /* end request_key_with_auxdata() */
> +
> +EXPORT_SYMBOL(request_key_with_auxdata);

can you consider making this a _GPL export please? The entire key
subsystem is clearly linux specific, new functionality..

