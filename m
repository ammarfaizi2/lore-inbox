Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRCRFgx>; Sun, 18 Mar 2001 00:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCRFgp>; Sun, 18 Mar 2001 00:36:45 -0500
Received: from smarty.smart.net ([207.176.80.102]:26126 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S130882AbRCRFg2>;
	Sun, 18 Mar 2001 00:36:28 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200103180538.AAA14598@smarty.smart.net>
Subject: What's a return stack worth?
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Mar 2001 00:38:38 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These are the occurance counts of the 256 byte values in a big monolithic
stripped 2.4.0 UP 386 vmlinux. 1/256 is .39% .

    count    dec   hex  octal/ascii   %		possible meaning

    334170     0     0   [  0]    17.05%	ADD
     63889   255    ff   [377]     3.26%	2-byte escape
     63536    36    24       $     3.24%	AND	with AL
     52652   139    8b   [213]     2.68%	MOV
     50862   192    c0   [300]     2.59%	2 byte escape
     44628   131    83   [203]     2.27%	2-byte escape
     42419   137    89   [211]     2.16%	MOV
     39630   116    74       t     2.02%	JZ
     37832    32    20             1.93%	AND
     27742     1     1   [  1]     1.41%	ADD
     22879     4     4   [  4]     1.16%	ADD	with AL
     22307   232    e8   [350]     1.13%	CALL
     21945   196    c4   [304]     1.11%	LES
     21769    68    44       D     1.11%	INC	eSP
     19960   102    66       f     1.01%	other operand size prefix
     19793     8     8   [ 10]     1.01%	OR
     19212    15     f   [ 17]      .98%	2-byte escape
     18234   117    75       u      .93%	JNZ
     17335   101    65       e      .88%	GS prefix
     17204   141    8d   [215]      .87%	LEA
     17066    16    10   [ 20]      .87%	ADC
     16673   133    85   [205]      .85%	TEST
     14666    12     c   [ 14]      .74%	OR	with AL	
     13710   115    73       s      .69%	JNB
     13642   195    c3   [303]      .69%	RET near
     13293   246    f6   [366]      .67%	2-byte escape
     13103    83    53       S      .66%	PUSH	eBX
     12969   100    64       d      .66%	FS prefix
     12895   104    68       h      .65%	PUSH immediate
     12820     2     2   [  2]      .65%	ADD
     12525    37    25       %      .63%	AND	with eAX
     12412    20    14   [ 24]      .63%	ADC	with AL
     11661   114    72       r      .59%	JB
     11619    80    50       P      .59%	PUSH	eAX
     10791   128    80   [200]      .55%	2-byte escape
     10776    67    43       C      .54%	INC	eBX
     10702   199    c7   [307]      .54%	MOV
     10640   111    6f       o      .54%	OUTSW/D
     10577    24    18   [ 30]      .53%	SBB
     10546   124    7c       |      .53%	JL
     10517   105    69       i      .53%	IMUL
     10256    95    5f       _      .52%	POP	eDI
     10073    84    54       T      .51%	PUSH	eSP
     10055   110    6e       n      .51%	OUTSB
      9965   118    76       v      .50%	JBE
      9812    97    61       a      .50%	POPA
      9667    40    28       (      .49%	SUB
      9435    49    31       1      .48%	XOR
      9410    76    4c       L      .48%	DEC	eSP
      9304   108    6c       l      .47%	INSB
      9277     3     3   [  3]      .47%	ADD
      8988    64    40       @      .45%	INC	eAX
      8922    91    5b       [      .45%	POP	eBX
      8903   193    c1   [301]      .45%	2 byte escape
      8638   132    84   [204]      .44%	TEST
      8580   144    90   [220]      .43%	NOP
      8423    86    56       V      .42%	PUSH	eSI
      8422    48    30       0      .42%	XOR
      8417     5     5   [  5]      .42%	ADD	with eAX
      8267    28    1c   [ 34]      .42%	SBB	with AL
      8116   235    eb   [353]      .41%	JNP
      7963    46    2e       .      .40%	CS prefix
      7882    94    5e       ^      .40%	POP	eSI
      7856    99    63       c      .40%	ARPL
      7723   136    88   [210]      .39%	MOV
      7667    41    29       )      .39%	SUB
      7404    10     a   [ 12]      .37%	OR
      7226   112    70       p      .36%	JO
      7220   129    81   [201]      .36%	2-byte escape
      6818    57    39       9      .34%	CMP
      6732   138    8a   [212]      .34%	MOV
      6680   194    c2   [302]      .34%	RET near with stacked data
      6518    44    2c       ,      .33%	SUB	with AL
      6509    92    5c       \      .33%	POP	eSP
      6363   184    b8   [270]      .32%	MOV immediate 
      6246   224    e0   [340]      .31%	LOOPNE
      6139    85    55       U      .31%	PUSH	eBP
      6117    42    2a       *      .31%	SUB
      6001    87    57       W      .30%	PUSH	eDI
      5937   254    fe   [376]      .30%	INC/DEC
      5839   106    6a       j      .29%	PUSH immediate
      5829     7     7   [  7]      .29%	POP	ES
      5703   182    b6   [266]      .29%	MOV immediate 
      5654   198    c6   [306]      .28%	MOV
      5553    70    46       F      .28%	INC	eSI
      5327    93    5d       ]      .27%	POP	eBP
      5318    60    3c       <      .27%	CMP	with AL
      5301    58    3a       :      .27%	CMP
      5281   236    ec   [354]      .26%	IN
      5174    52    34       4      .26%	XOR	with AL
      5165   120    78       x      .26%	JS
      5156     9     9   [ 11]      .26%	OR
      5121   233    e9   [351]      .26%	JNP
      5014     6     6   [  6]      .25%	PUSH	ES
      4921    56    38       8      .25%	CMP
      4915    66    42       B      .25%	INC	eDX
      4913    65    41       A      .25%	INC	eCX
      4890    69    45       E      .24%	INC	eBP
      4846    13     d   [ 15]      .24%	OR	with eAX
      4825   240    f0   [360]      .24%	LOCK
      4768   248    f8   [370]      .24%	CLC
      4623   208    d0   [320]      .23%	2-byte escape
      4513   109    6d       m      .23%	INSW/D
      4488    82    52       R      .22%	PUSH	eDX
      4459    61    3d       =      .22%	CMP	with eAX
      4444   252    fc   [374]      .22%	CLD
      4411    43    2b       +      .22%	SUB
      4335    71    47       G      .22%	INC	eDI
      4235   210    d2   [322]      .21%	2-byte escape
      3918   238    ee   [356]      .19%	OUT
      3841    39    27       '      .19%	DAA
      3797    21    15   [ 25]      .19%	ADC	with eAX
      3778   250    fa   [372]      .19%	CLI
      3698   103    67       g      .18%	other address size prefix
      3629    72    48       H      .18%	DEC	eAX
      3612   219    db   [333]      .18%	coprocessor
      3525    38    26       &      .17%	ES prefix
      3431    50    32       2      .17%	XOR
      3349    73    49       I      .17%	DEC	eCX
      3340    33    21       !      .17%	AND
      3330   134    86   [206]      .16%	XCNG
      3257   119    77       w      .16%	JNBE
      3185   216    d8   [330]      .16%	coprocessor
      3142   200    c8   [310]      .16%	ENTER
      3126   247    f7   [367]      .15%	2-byte escape
      2980    17    11   [ 21]      .15%	ADC
      2977   121    79       y      .15%	JNS
      2963   226    e2   [342]      .15%	LOOP
      2953   176    b0   [260]      .15%	MOV immediate 
      2930   251    fb   [373]      .14%	STI
      2891   243    f3   [363]      .14%	REP
      2885    11     b   [ 13]      .14%	OR
      2875   126    7e       ~      .14%	JLE
      2857   183    b7   [267]      .14%	MOV immediate 
      2856    78    4e       N      .14%	DEC	eSI
      2834    98    62       b      .14%	BOUND
      2812    88    58       X      .14%	POP	eAX
      2740    14     e   [ 16]      .13%	PUSH	CS
      2734    18    12   [ 22]      .13%	ADC
      2725   242    f2   [362]      .13%	REPNE
      2693   127    7f   [177]      .13%	JNLE
      2692   156    9c   [234]      .13%	PUSHF
      2650    81    51       Q      .13%	PUSH	eCX
      2636   161    a1   [241]      .13%	MOV
      2618    47    2f       /      .13%	DAS
      2585    25    19   [ 31]      .13%	SBB
      2563   201    c9   [311]      .13%	LEAVE
      2537   237    ed   [355]      .12%	IN
      2528    22    16   [ 26]      .12%	PUSH	SS
      2510   249    f9   [371]      .12%	STC
      2505   107    6b       k      .12%	IMUL
      2485    19    13   [ 23]      .12%	ADC
      2484   135    87   [207]      .12%	XCNG
      2467   185    b9   [271]      .12%	MOV immediate 
      2419   140    8c   [214]      .12%	MOV
      2384    45    2d       -      .12%	SUB	with eAX
      2372    77    4d       M      .12%	DEC	eBP
      2372    51    33       3      .12%	XOR
      2341   168    a8   [250]      .11%	TEST
      2325    62    3e       >      .11%	CS prefix 		
      2305   253    fd   [375]      .11%	STD
      2283   218    da   [332]      .11%	coprocessor
      2282   202    ca   [312]      .11%	RET far
      2262   148    94   [224]      .11%	XCHG	eSP
      2241    53    35       5      .11%	XOR	with eAX
      2224   125    7d       }      .11%	JNL
      2197   180    b4   [264]      .11%	MOV immediate 
      2161   130    82   [202]      .11%	
      2128    26    1a   [ 32]      .10%	SBB
      2122   172    ac   [254]      .10%	LODSB
      2118   197    c5   [305]      .10%	LDS
      2101    29    1d   [ 35]      .10%	SBB	with eAX
      2078    23    17   [ 27]      .10%	POP	SS
      2068   186    ba   [272]      .10%	MOV immediate 
      2035    34    22       "      .10%	AND
      2024    31    1f   [ 37]      .10%	POP	DS
      2016    79    4f       O      .10%	DEC	eDI
      1994    75    4b       K      .10%	DEC	eBX
      1981   188    bc   [274]      .10%	MOV immediate 
      1976   239    ef   [357]      .10%	OUT
      1951   244    f4   [364]      .09%	HLT
      1933    96    60       `      .09%	PUSHA
      1918   160    a0   [240]      .09%	MOV
      1886    35    23       #      .09%	AND
      1884   187    bb   [273]      .09%	MOV immediate 
      1870    54    36       6      .09%	SS prefix
      1855    55    37       7      .09%	AAA
      1849   234    ea   [352]      .09%	JNP
      1811   190    be   [276]      .09%	MOV immediate 
      1797   225    e1   [341]      .09%	LOOPE
      1788    30    1e   [ 36]      .09%	PUSH	DS
      1719   211    d3   [323]      .08%	2-byte escape
      1678   228    e4   [344]      .08%	IN	AL
      1636   191    bf   [277]      .08%	MOV immediate 
      1621   123    7b       {      .08%	JNP
      1619   230    e6   [346]      .08%	OUT	AL
      1596    27    1b   [ 33]      .08%	SBB
      1590   157    9d   [235]      .08%	POPF
      1582   165    a5   [245]      .08%	MOVSW/D
      1545   152    98   [230]      .07%	CBW
      1506   164    a4   [244]      .07%	MOVSB
      1427   245    f5   [365]      .07%	CMC
      1406   227    e3   [343]      .07%	JCXZ
      1333   222    de   [336]      .06%	coprocessor
      1331   209    d1   [321]      .06%	2-byte escape
      1311    63    3f       ?      .06%	AAS
      1305   171    ab   [253]      .06%	STOSW/D
      1291   113    71       q      .06%	JNO
      1271   241    f1   [361]      .06%	
      1270    74    4a       J      .06%	DEC	eDX
      1214   220    dc   [334]      .06%	coprocessor
      1184   122    7a       z      .06%	JP
      1123   189    bd   [275]      .05%	MOV immediate 
      1120   142    8e   [216]      .05%	MOV
      1104   212    d4   [324]      .05%	AAM
      1100    89    59       Y      .05%	POP	eCX
      1098   223    df   [337]      .05%	coprocessor
      1094   163    a3   [243]      .05%	MOV	
      1037   149    95   [225]      .05%	XCHG	eBP
      1006   147    93   [223]      .05%	XCHG	eBX
       994   179    b3   [263]      .05%	MOV immediate 
       972   204    cc   [314]      .04%	INT 3
       966   217    d9   [331]      .04%	coprocessor
       955    90    5a       Z      .04%	POP	eDX
       930   231    e7   [347]      .04%	OUT	eAX
       905    59    3b       ;      .04%	CMP
       875   174    ae   [256]      .04%	SCASB
       874   145    91   [221]      .04%	XCHG	eCX
       857   229    e5   [345]      .04%	IN	eAX
       854   203    cb   [313]      .04%	RET far
       836   214    d6   [326]      .04%	
       833   181    b5   [265]      .04%	MOV immediate 
       833   143    8f   [217]      .04%	POP
       825   207    cf   [317]      .04%	IRET
       824   146    92   [222]      .04%	XCHG	eDX
       809   206    ce   [316]      .04%	INTO
       806   213    d5   [325]      .04%	AAD
       777   153    99   [231]      .03%	CWD
       758   158    9e   [236]      .03%	SAHF
       758   150    96   [226]      .03%	XCHG	eSI
       755   159    9f   [237]      .03%	LAHF
       751   215    d7   [327]      .03%	XLAT
       748   177    b1   [261]      .03%	MOV immediate 
       735   178    b2   [262]      .03%	MOV immediate 
       735   173    ad   [255]      .03%	LODSW/D
       731   170    aa   [252]      .03%	STOSB
       722   205    cd   [315]      .03%	INT
       684   221    dd   [335]      .03%	coprocessor
       669   155    9b   [233]      .03%	WAIT
       638   151    97   [227]      .03%	XCHG	eDI
       577   166    a6   [246]      .02%	CMPSB
       567   175    af   [257]      .02%	SCASW/D
       529   154    9a   [232]      .02%	CALL	
       515   169    a9   [251]      .02%	TEST
       513   162    a2   [242]      .02%	MOV
       386   167    a7   [247]      .01%	CMPSW/D


Considering 386 opcodes as "signal" (and throwing out the zeros), decimal
36 looks like a spike in the noise due to a modR/M byte value. 36 decimal
is the pmode modR/M byte saying "this instruction uses a memory reference
with a one-byte literal displacement value." gcc does a lot of that, for
locals I believe. LES, octal 304, is probably also actually a prevalent
modR/M value. Otherwise things look mostly as one might expect. ff, 1, 2,
4 and 8 are probably frequent as literals. The fact that there are more
4's than 2's meshes with the fact that it's a 4 byte machine as far as
vmlinux is concerned. There are a lot of 4's affiliated with that locals
addressing mode. ASCII text in the kernel seems to be a relatively light
factor. The apparent ratio between CALLs and RETs is about 1.6:1, which is
the low end of what I expected. I suspect 1.6:1 is representative though.
That interests me quite a lot. Is the exact ratio known? Has anyone ever
built a 100% inlined kernel?

Rick Hohensee
www.clienux.com
